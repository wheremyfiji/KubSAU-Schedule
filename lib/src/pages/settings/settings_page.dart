import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../build_date_time.dart';
import '../../providers/environment_provider.dart';
import '../../router/app_router.dart';
import '../../services/storage_service.dart';
import '../../utils/extensions/buildcontext.dart';
import '../../utils/extensions/string.dart';
import 'components/setting_option.dart';
import 'components/settings_group.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('Настройки'),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(16),
                    child: Consumer(builder: (context, ref, child) {
                      return SettingsOption(
                        title: 'Твоя группа:'
                            '${StorageService.instance.userGroup.capitalizeFirstTwoChars()}',
                        subtitle: 'Нажми, чтобы изменить',
                        onTap: () {
                          StorageService.instance.deleteUserGroup().then((_) {
                            StorageService.instance.userGroup = '';
                            ref
                                .read(routerNotifierProvider.notifier)
                                .userLogin = false;
                            context.goNamed('login');
                          });
                        },
                      );
                    }),
                  ),
                  SettingsGroup(
                    label: 'О приложении',
                    options: [
                      Consumer(
                        builder: (context, ref, child) {
                          final environment = ref.watch(environmentProvider);

                          final version = environment.packageInfo.version;
                          final build = environment.packageInfo.buildNumber;

                          DateTime appBuildTime =
                              DateTime.parse(appBuildDateTime);
                          final dateString =
                              DateFormat.yMMMMd().format(appBuildTime);
                          final timeString =
                              DateFormat.Hm().format(appBuildTime);

                          return SettingsOption(
                            title: 'Версия: $version ($build) ($kAppArch)',
                            subtitle: 'от $dateString ($timeString)',
                            // onTap: () {
                            //   ref
                            //       .read(routerNotifierProvider.notifier)
                            //       .userLogin = false;
                            //   context.goNamed('login');
                            // },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: context.mediaQuery.padding.bottom),
            ),
          ],
        ),
      ),
    );
  }
}

String get kAppArch {
  switch (Abi.current()) {
    case Abi.androidX64:
      return 'x86_64';
    case Abi.androidArm64:
      return 'arm64-v8a';
    case Abi.androidIA32:
    case Abi.androidArm:
      return 'armeabi-v7a';
    default:
      return Abi.current().toString();
  }
}
