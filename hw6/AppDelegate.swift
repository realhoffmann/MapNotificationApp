//
//  AppDelegate.swift
//  hw6
//
//  Created by Julian Hoffmann on 05.06.23.
//

import Foundation
import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print("Error: \(error)")
            }
        }
        
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
