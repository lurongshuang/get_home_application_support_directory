import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'get_home_application_support_directory_method_channel.dart';

abstract class GetHomeApplicationSupportDirectoryPlatform
    extends PlatformInterface {
  /// Constructs a GetHomeApplicationSupportDirectoryPlatform.
  GetHomeApplicationSupportDirectoryPlatform() : super(token: _token);

  static final Object _token = Object();

  static GetHomeApplicationSupportDirectoryPlatform _instance =
      MethodChannelGetHomeApplicationSupportDirectory();

  /// The default instance of [GetHomeApplicationSupportDirectoryPlatform] to use.
  ///
  /// Defaults to [MethodChannelGetHomeApplicationSupportDirectory].
  static GetHomeApplicationSupportDirectoryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GetHomeApplicationSupportDirectoryPlatform] when
  /// they register themselves.
  static set instance(GetHomeApplicationSupportDirectoryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// Gets the Application Support directory path on macOS.
  ///
  /// Returns the path to the Application Support directory, typically
  /// `/Users/username/Library/Application Support` on macOS.
  ///
  /// Throws [UnimplementedError] if not implemented for the current platform.
  Future<String?> getApplicationSupportDirectory() {
    throw UnimplementedError(
      'getApplicationSupportDirectory() has not been implemented.',
    );
  }
}
