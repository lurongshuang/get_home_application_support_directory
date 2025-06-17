import 'dart:io';
import 'get_home_application_support_directory_platform_interface.dart';

/// A Flutter plugin for getting the Application Support directory path on macOS.
///
/// This plugin provides access to the macOS Application Support directory,
/// which is typically located at `/Users/username/Library/Application Support`.
///
/// The Application Support directory is the standard location for:
/// - User-specific application data
/// - Configuration files
/// - Cached data
/// - User preferences
/// - Application-specific documents
class GetHomeApplicationSupportDirectory {
  /// Returns the platform version string (for testing purposes).
  ///
  /// This method is primarily used for debugging and testing to verify
  /// that the plugin is working correctly with the native platform.
  ///
  /// Returns a string containing the platform name and version,
  /// e.g., "macOS 14.0" on macOS systems.
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
  /// Throws [PlatformException] if there's an error accessing the directory.
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

  /// Checks if the current platform is supported by this plugin.
  ///
  /// Currently, only macOS is supported. This method returns `true` on macOS
  /// and `false` on all other platforms.
  ///
  /// Returns `true` if the plugin can function on the current platform,
  /// `false` otherwise.
  static bool get isSupported {
    return Platform.isMacOS;
  }

  /// Creates a subdirectory within the Application Support directory.
  ///
  /// This is a convenience method that first gets the Application Support
  /// directory path and then creates a subdirectory with the given name.
  ///
  /// [subdirectoryName] - The name of the subdirectory to create
  /// [recursive] - Whether to create parent directories if they don't exist
  ///
  /// Returns the path to the created subdirectory, or `null` if the
  /// Application Support directory couldn't be found.
  ///
  /// Throws [FileSystemException] if the directory cannot be created.
  ///
  /// Example:
  /// ```dart
  /// final plugin = GetHomeApplicationSupportDirectory();
  /// final myAppDir = await plugin.createSubdirectory('MyApp');
  /// print('My app directory: $myAppDir');
  /// ```
  Future<String?> createSubdirectory(
    String subdirectoryName, {
    bool recursive = true,
  }) async {
    if (!isSupported) {
      return null;
    }

    final basePath = await getApplicationSupportDirectory();
    if (basePath == null) {
      return null;
    }

    final subdirectoryPath = '$basePath/$subdirectoryName';
    final directory = Directory(subdirectoryPath);

    if (!await directory.exists()) {
      await directory.create(recursive: recursive);
    }

    return subdirectoryPath;
  }
}
