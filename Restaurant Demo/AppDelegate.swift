//
//  AppDelegate.swift
//  Restaurant Demo
//
//  Created by hany karam on 8/12/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "التالي"
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        if let  _ = UserDefaults.standard.value(forKey: "IDUSER")  as? Int {
                let sb = UIStoryboard(name: "Home", bundle: nil)
                var vc2: UIViewController
                vc2 = sb.instantiateViewController(withIdentifier: "HomeVC")
                window?.rootViewController = vc2
             }

        // Override point for customization after application launch.
        return true
    }
}

