//
//  AuthorizationDataManagerProtocol.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 09.11.2023.
//

import Foundation
import UIKit

protocol AuthorizationDataManagerProtocol {
    func loginToAccount(userName: String, password: String, completion: @escaping ((UserLogin?) -> Void))
}
