//
//  AppDelegate.swift
//  Timer
//
//  Created by 김승현 on 8/10/24.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    var notifDelegate = NotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = notifDelegate
        return true
    }
}
