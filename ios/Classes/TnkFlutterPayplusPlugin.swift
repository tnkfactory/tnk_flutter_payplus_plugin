import Flutter
import UIKit
import TnkRwdSdk2

public class TnkFlutterPayplusPlugin: NSObject, FlutterPlugin {
    
    static var channel:FlutterMethodChannel? = nil
    var vc:AdOfferwallViewController? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tnk_flutter_payplus_plugin", binaryMessenger: registrar.messenger())
        let instance = TnkFlutterPayplusPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        
        switch call.method {
        case "getPlatformVersion":
            print("getPlatformVersion")
            result("iOS " + UIDevice.current.systemVersion)
            
        case "setCOPPA":
            print("setCOPPA")
            if let args = call.arguments as? Dictionary<String, Any>,
               let coppa = args["coppa"] as? Bool {
                TnkSession.sharedInstance()?.setCOPPA(coppa)
            } else{
                TnkSession.sharedInstance()?.setCOPPA(false)
            }
            result("success")
            
        case "showOfferwall":
            print("showOfferwall")
            
            if let args = call.arguments as? Dictionary<String, Any>,
               let map = args["map"] as? Dictionary<String,String> {
                
                let appId = map["IOS_APP_ID", default: ""]
                let scheme = map["IOS_SCHEME", default: ""]
                
                
                if( scheme != "" && appId != "" ) {
                    
                    let kakaoPlus =
                    KaKaoTnkRwdPlus.initSession(appId: appId)
                        .setUrlScheme(scheme)
                    kakaoPlus.showOfferwall(viewController!)
                    result("show offerwall")
                    
                } else {
                    result("arguments is required")
                }
            } else {
                result("error :: non arguments")
            }
                           
                           
                           
                           
               
            
            
            
//            let args = call.arguments as? Dictionary<String, Any>
//            if( args != nil ) {
//                let scheme = args?["scheme"] as? String ?? ""
//                let iosAppId = args?["iosAppId"] as? String ?? ""
//                
//                if( scheme != "" && iosAppId != "" ) {
//                    
//                    let kakaoPlus =
//                    KaKaoTnkRwdPlus.initSession(appId: iosAppId)
//                        .setUrlScheme(scheme)
//                    kakaoPlus.showOfferwall(viewController!)
//                    result("show offerwall")
//                    
//                } else {
//                    result("arguments is required")
//                }
//            } else {
//                result("error :: non arguments")
//            }
            


            
            
        case "showATTPopup" :
            TnkAlerts.showATTPopup(
                viewController!,
                agreeAction: {// 사용자 동의함
                    result("IOS -> ATT Agree " + UIDevice.current.systemVersion)
                },
                denyAction:{ // 동의하지 않음
                    result("IOS -> ATT Deny " + UIDevice.current.systemVersion)
                })
            
            result("success")
            break;
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
