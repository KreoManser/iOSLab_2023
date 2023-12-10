//
//  RegistraitonDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 07.12.2023.
//

import Foundation
class RegistrationDataManager: NSObject {
    static let shared = RegistrationDataManager()
    var coredatamanager: CoreDataManager?
    var didTapRegisterButton: (() -> Void)?
    var didTapRedirectionButton: (() -> Void)?

    override init() {
        super.init()
    }

    private func saveUser(_ username: String, _ password: String) {
        guard let context = coredatamanager?.viewContext else {
            print("context absent")
            return
        }
        let newUser = User(context: context)
        newUser.username = username
        newUser.password = password
        do {
            coredatamanager?.saveContext()
        }
    }
}
