import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'get_home_application_support_directory_platform_interface.dart';

/// An implementation of [GetHomeApplicationSupportDirectoryPlatform] that uses method channels.
class MethodChannelGetHomeApplicationSupportDirectory
    extends GetHomeApplicationSupportDirectoryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(
    'get_home_application_support_directory',
  );

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<String?> getApplicationSupportDirectory() async {
    final path = await methodChannel.invokeMethod<String>(
      'getApplicationSupportDirectory',
    );
    return path;
  }
}
