//
//  RegistrationViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 07.12.2023.
//

import UIKit
import CoreData

class RegistrationViewController: UIViewController, RegistrationViewDelegate {

    private var registrationView: RegistrationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettings()
    }

    func saveСredentials() {
        guard
            let login = registrationView?.fieldLogin.text,
            let password = registrationView?.fieldPassword.text,
            let duplicateFieldPassword = registrationView?.duplicateFieldPassword.text
        else { return }
        if password == duplicateFieldPassword {
            let registraitionEntity = RegistraitionEntity(context: RegistrationDataManager.shared.viewContext)
            registraitionEntity.userName = login
            registraitionEntity.password = password
            RegistrationDataManager.shared.saveContext()
            createListPublicationsForNewUser(userName: registraitionEntity.userName, password: registraitionEntity.password)
            let alert = UIAlertController(
                title: "Успешно",
                message: "Ваш логин: \(registraitionEntity.userName)\nВаш пароль: \(registraitionEntity.password)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "ок", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Неверные данные", message: "Пароли не совпадают", preferredStyle: .alert)
            let action = UIAlertAction(title: "Закрыть", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }

    func createListPublicationsForNewUser(userName: String, password: String) {
        ProfileDataManager.shared.publicationsDictionary[userName] = []
    }

    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }

    private func setUpSettings() {
        registrationView = RegistrationView(frame: .zero)
        view = registrationView
        registrationView?.delegate = self
    }
}
