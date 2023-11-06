//
//  AuthViewController.swift
//  107Tukaev
//
//  Created by surexnx on 02.11.2023.
//

import UIKit

class AuthViewController: UIViewController {

    private lazy var customview: AuthView = {
        return AuthView(frame: .zero)
    }()

    var dataManagerUser: DataManagerUser?
    var dataManagerPublication: DataManagerPublication?

    override func loadView() {
        view = customview
        customview.contoller = self
        customview.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataManagerUser = DataManagerUser.shared
        dataManagerPublication = DataManagerPublication.shared
    }
}

extension AuthViewController: CheckAuthDelegate {

    func checkAuth(login: String, password: String) {

        Task {
            let user = await dataManagerUser?.auth(login: login, password: password)
            if let user = user {
                dataManagerPublication?.setUser(user: user)
                if let image = user.userImage {
                    let tapbarController = TapBarController(userImage: image)
                    navigationController?.pushViewController(tapbarController, animated: true)
                }
            }
        }
    }
}
