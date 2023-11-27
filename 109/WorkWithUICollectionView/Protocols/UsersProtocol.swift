//
//  DataManagerProtocol.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 07.11.2023.
//

import Foundation

protocol UsersProtocol: AnyObject {
    func asyncCheckedUser(login: String, password: String, completion: @escaping (User?) -> Void)
}
