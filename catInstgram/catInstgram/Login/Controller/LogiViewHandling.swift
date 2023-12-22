//
//  LogiViewController.swift
//  catInstgram
//
//  Created by marwa awwad mohamed awwad on 22/12/2023.
//

import Foundation
import UIKit
protocol LoginHandlingProtocol {
    func userVertification(_ login: String, _ password: String) async -> User?
}

class LogiViewHandling:  LoginHandlingProtocol {
    func userVertification(_ login: String, _ password: String) async -> User? {
        let users = await DataManager.shared.asyncGetUsers()
        return users.first(where: {$0.name == login && $0.password == password})
    }
}

  
    
   



