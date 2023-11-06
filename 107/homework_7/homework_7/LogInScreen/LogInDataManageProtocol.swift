//
//  LogInDataManageProtocol.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import Foundation

protocol LogInDataManageProtocol {
    func checkUserExists(username: String, password: String, completion: @escaping (User?) -> Void)
}
