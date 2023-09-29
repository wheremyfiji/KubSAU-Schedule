import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../providers/schedule_api_provider.dart';
import '../../router/app_router.dart';
import '../../utils/app_utils.dart';
import '../../utils/extensions/buildcontext.dart';
import '../../services/storage_service.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textFieldController = useTextEditingController();
    final userGroup = useState('');

    useEffect(
      () {
        textFieldController.addListener(() {
          userGroup.value = textFieldController.text;
        });

        return null;
      },
      [textFieldController.value],
    );

    ref.listen<AsyncValue<void>>(
      continueButtonProvider,
      (_, state) => state.whenOrNull(
        error: (error, stackTrace) => AppUtils().showErrorSnackBar(
          context,
          content: error.toString(),
        ),
      ),
    );

    final continueButtonState = ref.watch(continueButtonProvider);
    final isLoading = continueButtonState is AsyncLoading<void>;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          top: false,
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: context.mediaQuery.padding.bottom,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Привет!',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Для продолжения введи номер своей группы',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextField(
                            autocorrect: false,
                            controller: textFieldController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              labelText: 'Номер группы',
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FilledButton(
                            onPressed: (userGroup.value.length < 6 || isLoading)
                                ? null
                                : () async {
                                    RegExp regex =
                                        RegExp(r'^[а-яА-Я]{2}\d{4}$');

                                    if (!regex.hasMatch(userGroup.value)) {
                                      textFieldController.clear();
                                      AppUtils().showErrorSnackBar(
                                        context,
                                        content: 'Неверный номер группы',
                                      );
                                      return;
                                    }

                                    StorageService.instance.userGroup =
                                        userGroup.value;

                                    await ref
                                        .read(continueButtonProvider.notifier)
                                        .check(onFinally: () {
                                      ref
                                          .read(routerNotifierProvider.notifier)
                                          .userLogin = true;
                                      GoRouter.of(context).go('/');
                                    });
                                  },
                            child: isLoading
                                ? const SizedBox.square(
                                    dimension: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  )
                                : const Text('Продолжить'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

final continueButtonProvider =
    StateNotifierProvider<ContinueButtonController, AsyncValue<void>>((ref) {
  return ContinueButtonController(
    ref: ref,
    scheduleApi: ref.read(scheduleApiProvider),
  );
}, name: 'continueButtonProvider');

class ContinueButtonController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;
  final ScheduleApi scheduleApi;

  ContinueButtonController({
    required this.ref,
    required this.scheduleApi,
  }) : super(const AsyncValue.data(null));

  Future<void> check({
    required VoidCallback onFinally,
  }) async {
    try {
      state = const AsyncValue.loading();

      await scheduleApi.getScheduleByGroup(
        groupName: StorageService.instance.userGroup,
      );

      await StorageService.instance.writeUserGroup(
        StorageService.instance.userGroup,
      );

      onFinally();
    } catch (error, s) {
      state = AsyncValue.error(error, s);
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}
