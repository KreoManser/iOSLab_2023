//
//  LoginDataManageProtocol.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import Foundation

protocol LogInDataManageProtocol {
    func checkUserExists(username: String, password: String, completion: @escaping (User?) -> Void)
}
