import 'dart:async';

import 'package:package_info/package_info.dart';

class AppInfo {
  // Singleton instance code
  static final AppInfo _instance = AppInfo._();
  static AppInfo get instance => _instance;
  AppInfo._();

  PackageInfo _info;

  String get appName => _info.appName ?? 'Perfect Flirt';
  Future<void> init() async => _info = await PackageInfo.fromPlatform();

  String get packageName => _info.packageName;
  String get versionAndBuild => _info.version + '+' + _info.buildNumber;
}
