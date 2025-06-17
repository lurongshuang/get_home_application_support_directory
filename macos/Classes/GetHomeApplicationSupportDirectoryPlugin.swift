import Cocoa
import FlutterMacOS

/// Flutter plugin for accessing the macOS Application Support directory
/// 
/// This plugin provides a simple interface to retrieve the path to the
/// Application Support directory on macOS, which is the standard location
/// for storing user-specific application data.
public class GetHomeApplicationSupportDirectoryPlugin: NSObject, FlutterPlugin {
  
  /// Registers the plugin with the Flutter engine
  /// - Parameter registrar: The plugin registrar provided by Flutter
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "get_home_application_support_directory", binaryMessenger: registrar.messenger)
    let instance = GetHomeApplicationSupportDirectoryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  /// Handles method calls from Flutter
  /// - Parameters:
  ///   - call: The method call containing the method name and arguments
  ///   - result: The result callback to send data back to Flutter
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "getApplicationSupportDirectory":
      getApplicationSupportDirectory(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  /// Retrieves the Application Support directory path
  /// 
  /// This method uses NSSearchPathForDirectoriesInDomains to find the
  /// Application Support directory in the local domain (user's home directory).
  /// 
  /// - Parameter result: The Flutter result callback
  private func getApplicationSupportDirectory(result: @escaping FlutterResult) {
    let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .localDomainMask, true)
    
    guard let applicationSupportPath = paths.first else {
      result(FlutterError(
        code: "DIRECTORY_NOT_FOUND", 
        message: "Application Support directory not found in local domain", 
        details: "NSSearchPathForDirectoriesInDomains returned empty array"
      ))
      return
    }
    
    // Verify the path exists and is accessible
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    
    if fileManager.fileExists(atPath: applicationSupportPath, isDirectory: &isDirectory) {
      if isDirectory.boolValue {
        result(applicationSupportPath)
      } else {
        result(FlutterError(
          code: "INVALID_DIRECTORY", 
          message: "Application Support path exists but is not a directory", 
          details: "Path: \(applicationSupportPath)"
        ))
      }
    } else {
      result(FlutterError(
        code: "DIRECTORY_INACCESSIBLE", 
        message: "Application Support directory exists but is not accessible", 
        details: "Path: \(applicationSupportPath)"
      ))
    }
  }
}
