import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/environment_provider.dart';
import 'router/app_router.dart';
import 'utils/dynamic_colors.dart';
import 'utils/extensions/buildcontext.dart';
import 'widgets/app_theme_builder.dart';

class KubsauSchedule extends ConsumerWidget {
  const KubsauSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final environment = ref.watch(environmentProvider);
    final router = ref.watch(appRouterProvider);
    final dynamicColors = ref.watch(dynamicColorsProvider);

    final isNightMode = context.brightness == Brightness.dark;
    final foregroundBrightness =
        isNightMode ? Brightness.light : Brightness.dark;

    final defStyle =
        (isNightMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
            .copyWith(statusBarColor: Colors.transparent);

    final style = defStyle.copyWith(
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: foregroundBrightness,
      systemNavigationBarIconBrightness: foregroundBrightness,
      systemNavigationBarContrastEnforced: false,
    );

    return AppThemeBuilder(
      dynamicLight: dynamicColors?.light,
      dynamicDark: dynamicColors?.dark,
      useMonet: true,
      builder: (context, appTheme) {
        return AnnotatedRegion(
          value: (environment.sdkVersion ?? 0) > 28 ? style : defStyle,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Расписание КубГАУ',
            themeMode: ThemeMode.system,
            theme: appTheme.light,
            darkTheme: appTheme.dark,
            routerConfig: router,
            builder: (context, child) {
              if (!kDebugMode) {
                ErrorWidget.builder = (FlutterErrorDetails error) {
                  return const Center(
                    child: Text('Произошла ошибка'),
                  );
                };
              }

              /// fix high textScaleFactor
              final mediaQuery = MediaQuery.of(context);
              final scale = mediaQuery.textScaleFactor.clamp(0.8, 1).toDouble();

              return MediaQuery(
                data: mediaQuery.copyWith(textScaleFactor: scale),
                child: child!,
              );
            },
          ),
        );
      },
    );
  }
}
