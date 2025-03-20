import Flutter
import UIKit
import TnkRwdSdk2

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    
//    var window: UIWindow?
    
    
    // 카카오 페이앱으로 부터 로그인이 완료된 후 데이터를 넘겨받기 위한 스키마 처리 작업을 진행
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return KaKaoTnkRwdPlus.proceedUrlAppDelegate(open: url)
    }
    
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
