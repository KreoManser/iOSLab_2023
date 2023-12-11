//
//  OptionsDataManager.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
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
