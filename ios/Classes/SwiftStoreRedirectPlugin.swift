import Flutter
import UIKit

public class SwiftStoreRedirectPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "store_redirect",
            binaryMessenger: registrar.messenger()
        )
        let instance = SwiftStoreRedirectPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]
        
        switch(call.method){
        case "redirect":
            performRedirect(arguments, result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func performRedirect(
        _ args: [String: Any]?,
        _ result: @escaping FlutterResult
    ) {
        // Ensure a valid app ID is provided, otherwise report an error and return
        guard let appId = args?["ios_id"] as? String else {
            let error = FlutterError(
                code: "ERROR",
                message: "Invalid app id",
                details: nil
            )
            result(error)
            return
        }
        
        redirectToStore(appId: appId, result: result)
    }
    
    private func redirectToStore(appId: String, result: @escaping FlutterResult){
        var itunesLink = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appId)"
        
        if #available(iOS 11.0, *) {
            itunesLink = "itms-apps://itunes.apple.com/xy/app/foo/id\(appId)"
        }
        
        guard let url = URL(string: itunesLink) else {
            let error = FlutterError(
                code: "ERROR",
                message: "Invalid App Store url: \(itunesLink)",
                details: nil
            )
            result(error)
            return
        }
        
        // Fix deprecation warnings for projects targeting iOS 10.0+
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:]) { (success) in
                guard success else {
                    let error = FlutterError(
                        code: "ERROR",
                        message: "Failed to open url \(url)",
                        details: nil
                    )
                    result(error)
                    return
                }
                
                result(nil)
            }
        } else {
            UIApplication.shared.openURL(url)
            result(nil)
        }
    }
    
}
