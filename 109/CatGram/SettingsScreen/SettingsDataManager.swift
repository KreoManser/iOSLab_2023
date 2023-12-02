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
//    static let shared = SettingsDataManager()
//    var isDarkMode: Bool?
//    var userDefaults = UserDefaults.standard
//
//    private(set) var currentTheme: Theme = .light {
//        didSet {
//           toggleTheme()
//        }
//    }
//    override init() {
//        super.init()
//        self.saveThemePreference()
//    }
//
//    func toggleTheme() {
//        let windowScenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
//        if isDarkMode == true {
//            currentTheme = .dark
//            windowScenes.forEach { windowScene in
//                windowScene.windows.forEach { window in
//                    window.overrideUserInterfaceStyle = .dark
//                }
//            }
//        } else {
//                    currentTheme = .light
//                    windowScenes.forEach { windowScene in
//                        windowScene.windows.forEach { window in
//                            window.overrideUserInterfaceStyle = .light
//                        }
//                    }
//                }
//
//        }
//    private func saveThemePreference() {
//        userDefaults.setValue(currentTheme.rawValue, forKey: Keys.themePreference)
//    }

    static let shared = SettingsDataManager()
        var isDarkMode: Bool {
            didSet {
                applyTheme()
            }
        }
        var userDefaults = UserDefaults.standard

        override init() {
            self.isDarkMode = userDefaults.bool(forKey: Keys.isDarkMode)
            super.init()
        }

        func toggleTheme() {
            isDarkMode.toggle()
            userDefaults.set(isDarkMode, forKey: Keys.isDarkMode)
        }

        private func applyTheme() {
            let theme = isDarkMode ? Theme.dark : Theme.light
            let windowScenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }

            windowScenes.forEach { windowScene in
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = theme == .dark ? .dark : .light
                }
            }
        }
}
