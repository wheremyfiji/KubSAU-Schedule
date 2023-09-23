import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dynamic_color/dynamic_color.dart';

final appThemeDataProvider = Provider.autoDispose<AppThemeDataNotifier>((ref) {
  return AppThemeDataNotifier();
});

class AppThemeData {
  const AppThemeData({
    required this.light,
    required this.dark,
  });

  final ThemeData light;
  final ThemeData dark;
}

class AppThemeDataNotifier {
  late AppThemeData _data = _createAppThemeData();

  AppThemeData get data => _data;

  AppThemeData fillWith(
      {ColorScheme? light, ColorScheme? dark, bool? useMonet}) {
    _data = _createAppThemeData(light: light, dark: dark, useMonet: useMonet);
    return _data;
  }

  AppThemeData _createAppThemeData(
      {ColorScheme? light, ColorScheme? dark, bool? useMonet}) {
    return AppThemeData(
      light: _createThemeData(light, Brightness.light, useMonet!),
      dark: _createThemeData(dark, Brightness.dark, useMonet),
    );
  }

  ThemeData _createThemeData(
      ColorScheme? scheme, Brightness brightness, bool useMonet) {
    final isDark = brightness == Brightness.dark;
    final defScheme = isDark ? defDarkScheme : defLightScheme;
    final harmonized = useMonet ? scheme?.harmonized() ?? defScheme : defScheme;
    final colorScheme = harmonized.copyWith(
      outlineVariant: harmonized.outlineVariant.withOpacity(0.3),
    );
    final origin = isDark
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true);

    return origin.copyWith(
      //visualDensity: VisualDensity.standard,
      useMaterial3: true,
      colorScheme: colorScheme,
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      dialogBackgroundColor: colorScheme.background,
      drawerTheme: origin.drawerTheme.copyWith(
        backgroundColor: colorScheme.surface,
      ),
      cardTheme: origin.cardTheme.copyWith(
        margin: const EdgeInsets.all(0.0),
        shadowColor: Colors.transparent,
      ),
      snackBarTheme: origin.snackBarTheme.copyWith(
        backgroundColor: colorScheme.secondaryContainer,
        contentTextStyle: TextStyle(color: colorScheme.onSecondaryContainer),
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      // listTileTheme: origin.listTileTheme.copyWith(
      //   minVerticalPadding: 12,
      //   iconColor: colorScheme.onSurfaceVariant,
      // ),
    );
  }

  static const defaultAccent = Colors.lightBlue;

  static final defLightScheme = ColorScheme.fromSeed(
    seedColor: defaultAccent,
    brightness: Brightness.light,
  );

  static final defDarkScheme = ColorScheme.fromSeed(
    seedColor: defaultAccent,
    brightness: Brightness.dark,
  );
}
