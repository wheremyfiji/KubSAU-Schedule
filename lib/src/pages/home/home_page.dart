import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../providers/home_page_provider.dart';
import '../../services/storage_service.dart';
import '../../utils/app_utils.dart';
import '../../utils/extensions/buildcontext.dart';
import '../../utils/extensions/string.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/lesson_card.dart';

final _tabs = <int, String>{
  1: 'Понедельник',
  2: 'Вторник',
  3: 'Среда',
  4: 'Четверг',
  5: 'Пятница',
  6: 'Суббота',
};

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homePageProvider);
    final currentTimeOfDay = useState(TimeOfDay.now());
    final tabController = useTabController(
      initialLength: 6,
    );

    final isLoading = provider.scheduleAsync.isLoading &&
        !provider.scheduleAsync.hasError &&
        !provider.scheduleAsync.hasValue;

    useEffect(
      () {
        final timer = Timer.periodic(const Duration(seconds: 10), (time) {
          currentTimeOfDay.value = TimeOfDay.now();
        });
        return () => timer.cancel();
      },
    );

    useEffect(() {
      tabController.animateTo(provider.currentDayOfWeek - 1);
      return null;
    }, [provider.scheduleAsync]);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              forceElevated: innerBoxIsScrolled,
              title: const Text('Расписание'),
              actions: [
                IconButton(
                  onPressed: () => context.pushNamed('settings'),
                  icon: const Icon(Icons.settings),
                ),
              ],
              bottom: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorWeight: 1.5,
                //dividerColor: Colors.transparent,
                splashBorderRadius: BorderRadius.circular(12.0),
                tabs: _tabs.values
                    .map(
                      (e) => Tab(
                        text: e,
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ];
        },
        body: SafeArea(
          top: false,
          bottom: false,
          child: provider.scheduleAsync.when(
            data: (data) {
              final weeks = data.weeks;

              if (weeks == null) {
                return const Text('weeks == null');
              }

              return TabBarView(
                controller: tabController,
                children: _tabs.keys.map((e) {
                  final day =
                      weeks[provider.selectedWeek].lessons!.firstWhereOrNull(
                            (element) => element.dayOfWeek == e,
                          );

                  if (day == null) {
                    return RefreshIndicator(
                      onRefresh: () async => ref.invalidate(homePageProvider),
                      child: Stack(
                        children: <Widget>[ListView(), const NoLessonsWidget()],
                      ),
                    );
                  }

                  final lessons = day.lessons;

                  if (lessons == null) {
                    return const Center(child: Text('lessons == null'));
                  }

                  return RefreshIndicator(
                    // onRefresh: () =>
                    //     ref.refresh(scheduleApiProvider(group).future),
                    onRefresh: () async => ref.invalidate(homePageProvider),
                    child: CustomScrollView(
                      key: PageStorageKey<String>('Tab $e'),
                      scrollDirection: Axis.vertical,
                      slivers: [
                        const SliverPadding(padding: EdgeInsets.only(top: 16)),
                        SliverList.builder(
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            final lesson = lessons[index];

                            final now = DateTime.now();

                            final lessonNumber = lesson.lessonNumber ?? 1;
                            final time = AppUtils().getLessonTime(
                              lessonNumber,
                              isSaturday: now.weekday == DateTime.saturday,
                            );

                            final current = (provider.currentDayOfWeek ==
                                    lesson.dayOfWeek) &&
                                AppUtils().timeIsBetween(
                                  currentTimeOfDay.value,
                                  time.start,
                                  time.end,
                                ) &&
                                now.weekday != DateTime.sunday;

                            return Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                              child: LessonCard(
                                lesson: lesson,
                                time: time,
                                current: current,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
            error: (e, _) => Center(
                child: CustomErrorWidget(
              e.toString(),
              () => ref.invalidate(homePageProvider),
            )),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        shadowColor: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        type: MaterialType.card,
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: Padding(
          padding: EdgeInsets.only(
            top: 16,
            bottom: context.mediaQuery.viewPadding.bottom,
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      StorageService.instance.userGroup
                          .capitalizeFirstTwoChars(),
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      provider.selectedWeek == 1 ? '2 неделя' : '1 неделя',
                    ),
                  ),

                  // Wrap(
                  //   spacing: 4,
                  //   children: [
                  //     CompactTextButton(
                  //       label: '1 неделя',
                  //       selected: provider.selectedWeek == 0,
                  //       onPressed: () => provider.changeWeek(0),
                  //     ),
                  //     const Text('•'),
                  //     CompactTextButton(
                  //       label: '2 неделя',
                  //       selected: provider.selectedWeek == 1,
                  //       onPressed: () => provider.changeWeek(1),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(Icons.restore),
                  //       style: const ButtonStyle(
                  //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //         visualDensity: VisualDensity.compact,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              const Spacer(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 300),
                child: isLoading
                    ? const SizedBox.shrink()
                    : IconButton.filledTonal(
                        tooltip: 'Выбор недели',
                        icon: const Icon(Icons.event_rounded),
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          //visualDensity: VisualDensity.compact,
                          // padding: MaterialStateProperty.all<EdgeInsets>(
                          //   const EdgeInsets.all(0),
                          // ),
                        ),
                        onPressed: () {
                          final updateDate = provider.scheduleAsync.asData
                              ?.value.weeks?[provider.selectedWeek].dtUpdated;

                          showModalBottomSheet<void>(
                            context: context,
                            useSafeArea: true,
                            showDragHandle: true,
                            useRootNavigator: true,
                            isScrollControlled: true,
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width >= 700
                                  ? 700
                                  : double.infinity,
                            ),
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        'Выбор недели',
                                        style: context.textTheme.titleLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        'Обновлено: ${DateFormat.yMMMd().format(updateDate!)}',
                                        style: context.textTheme.titleSmall,
                                      ),
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        '1 неделя${provider.currentWeek == 0 ? ' (текущая)' : ''}',
                                      ),
                                      value: 0,
                                      groupValue: provider.selectedWeek,
                                      onChanged: (value) {
                                        provider.changeWeek(value!);
                                        context.navigator.pop();
                                      },
                                    ),
                                    RadioListTile(
                                      title: Text(
                                        '2 неделя${provider.currentWeek == 1 ? ' (текущая)' : ''}',
                                      ),
                                      value: 1,
                                      groupValue: provider.selectedWeek,
                                      onChanged: (value) {
                                        provider.changeWeek(value!);
                                        context.navigator.pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoLessonsWidget extends StatelessWidget {
  const NoLessonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '(～￣▽￣)～',
            style: context.textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Занятий нет',
              style: context.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class CompactTextButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  const CompactTextButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? context.colorScheme.primary
        : context.colorScheme.onBackground;

    return Material(
      borderRadius: BorderRadius.circular(4),
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: color,
          ),
        ),
      ),
    );
  }
}
