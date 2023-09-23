import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class EnvironmentService {
  EnvironmentService({
    required this.packageInfo,
    this.androidInfo,
  });

  final PackageInfo packageInfo;
  final AndroidDeviceInfo? androidInfo;

  int? get sdkVersion => androidInfo?.version.sdkInt;
  String get appVersion => packageInfo.version;
}
