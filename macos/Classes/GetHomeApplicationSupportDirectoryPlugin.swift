import Cocoa
import FlutterMacOS

public class GetHomeApplicationSupportDirectoryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "get_home_application_support_directory", binaryMessenger: registrar.messenger)
    let instance = GetHomeApplicationSupportDirectoryPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

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
  
  private func getApplicationSupportDirectory(result: @escaping FlutterResult) {
    let paths = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .localDomainMask, true)
    if let applicationSupportPath = paths.first {
      result(applicationSupportPath)
    } else {
      result(FlutterError(code: "DIRECTORY_NOT_FOUND", 
                         message: "Application Support directory not found", 
                         details: nil))
    }
  }
}
