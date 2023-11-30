//
//  AppDelegate.swift
//  106Tukaev
//
//  Created by surexnx on 29.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
        }

    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }

    func saveData() {
        DataManagerPublication.shared.save()
    }
}

