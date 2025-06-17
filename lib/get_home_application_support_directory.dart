import 'get_home_application_support_directory_platform_interface.dart';

/// A Flutter plugin for getting the Application Support directory path on macOS.
///
/// This plugin provides access to the macOS Application Support directory,
/// which is typically located at `/Users/username/Library/Application Support`.
class GetHomeApplicationSupportDirectory {
  /// Returns the platform version string (for testing purposes).
  Future<String?> getPlatformVersion() {
    return GetHomeApplicationSupportDirectoryPlatform.instance
        .getPlatformVersion();
  }

  /// Gets the Application Support directory path on macOS.
  ///
  /// Returns the path to the Application Support directory, typically
  /// `/Users/username/Library/Application Support` on macOS.
  ///
  /// Returns `null` if the directory cannot be found or if called on
  /// an unsupported platform.
  ///
  /// Example:
  /// ```dart
  /// final plugin = GetHomeApplicationSupportDirectory();
  /// final path = await plugin.getApplicationSupportDirectory();
  /// print('Application Support directory: $path');
  /// ```
  Future<String?> getApplicationSupportDirectory() {
    return GetHomeApplicationSupportDirectoryPlatform.instance
        .getApplicationSupportDirectory();
  }
}
