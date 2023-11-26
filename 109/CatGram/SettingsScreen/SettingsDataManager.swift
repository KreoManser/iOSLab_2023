//
//  SettingsDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 26.11.2023.
//

import Foundation
import UIKit

enum Theme: String {
    case light
    case dark
}
class SettingsDataManager: NSObject {
    static let shared = SettingsDataManager()
    var isDarkMode: Bool?
    var userDefaults = UserDefaults.standard

    private(set) var currentTheme: Theme = .light {
           didSet {
               applyTheme()
           }
       }
    override init() {
        super.init()
        self.saveThemePreference()
    }

    func toggleTheme() {
        currentTheme = (currentTheme == .light) ? .dark: .light
        saveThemePreference()
    }

    private func saveThemePreference() {
        userDefaults.setValue(currentTheme.rawValue, forKey: Keys.themePreference)
    }

//    func applyTheme() {
//        let windowScenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
//        switch currentTheme {
//        case .light:
//            windowScenes.forEach { windowScene in
//                windowScene.windows.forEach { window in
//                    window.rootViewController?.view.backgroundColor = .white
//                }
//        }
//        case .dark:
//            windowScenes.forEach { windowScene in
//                windowScene.windows.forEach { window in
//                    window.rootViewController?.view.backgroundColor = .black
//                }
//            }
//        }
//    }

    func applyTheme() {
        let theme = currentTheme
        let sharedApplication = UIApplication.shared

        switch theme {
        case .light:
            if let windowScene = sharedApplication.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    if let rootViewController = window.rootViewController as? FeedViewController {
                        rootViewController.view.backgroundColor = .white

                    }
                }
            }
        case .dark:
            if let windowScene = sharedApplication.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    if let rootViewController = window.rootViewController as? FeedViewController {
                        rootViewController.view.backgroundColor = .black
                    }
                }
            }
        }
    }

}
