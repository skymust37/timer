//
//  TimerApp.swift
//  Timer
//
//  Created by 김승현 on 7/16/24.
//

import SwiftUI

@main
struct TimerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelgate
    
    var body: some Scene {
        WindowGroup {
            TimerView()
        }
    }
}
