//
//  AppDelegate.swift
//  MegaSena
//
//  Created by Usuário Convidado on 18/09/19.
//  Copyright © 2019 Usuário Convidado. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        switch userActivity.activityType {
        case UserActivityType.GenerateMegaSenaNumbers:
            guard let vc = window?.rootViewController as? ViewController else { return false }
            vc.generateNumbers()
        default:
            return false
        }
        
        return true
        
    }

}

