import 'dart:io';

import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'src/kubsau_schedule.dart';
import 'src/providers/environment_provider.dart';
import 'src/providers/network_provider.dart';
import 'src/services/environment_service.dart';
import 'src/utils/dynamic_colors.dart';
import 'src/utils/provider_logger.dart';
import 'src/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'ru_RU';
  initializeDateFormatting("ru_RU", null);

  await StorageService.initialize();

  final dynamicColors = await getDynamicColors();
  final packageInfo = await PackageInfo.fromPlatform();

  final tempDir = await path_provider.getTemporaryDirectory();
  final cacheStore = HiveCacheStore(tempDir.path);

  AndroidDeviceInfo? androidInfo;

  if (Platform.isAndroid) {
    androidInfo = await DeviceInfoPlugin().androidInfo;

    if (androidInfo.version.sdkInt > 28) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  runApp(
    ProviderScope(
      observers: const [
        ProviderLogger(),
      ],
      overrides: [
        dioCacheStroreProvider.overrideWithValue(cacheStore),
        dynamicColorsProvider.overrideWithValue(dynamicColors),
        environmentProvider.overrideWithValue(
          EnvironmentService(
            packageInfo: packageInfo,
            androidInfo: androidInfo,
          ),
        ),
      ],
      child: const KubsauSchedule(),
    ),
  );
}
