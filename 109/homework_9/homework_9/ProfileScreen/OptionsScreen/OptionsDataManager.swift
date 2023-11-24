//
//  OptionsDataManager.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import Foundation
import UIKit

class OptionsDataManager {

    let userDefaults = UserDefaults.standard

    func logOut() {
        userDefaults.removeObject(forKey: "loggedInUser")
        userDefaults.set(false, forKey: "isUserLogged")
    }
}
