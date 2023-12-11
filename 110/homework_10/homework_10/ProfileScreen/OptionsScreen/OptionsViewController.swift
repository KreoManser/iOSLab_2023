//
//  OptionsViewController.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class OptionsViewController: UIViewController {

    private var optionsView: OptionsView?
    private var optionsDataManager: OptionsDataManager?

    var onDismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsDataManager = OptionsDataManager()
        setUpOptionsView()
    }

    private func setUpOptionsView() {
        optionsView = OptionsView(frame: view.bounds)
        optionsView?.exitItem.itemTapped = {
            let alert = UIAlertController(title: "Подтверждение", message: "Выйти из аккаунта?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = LogInViewController()
                    sceneDelegate.window?.makeKeyAndVisible()
                    }
                self.optionsDataManager?.logOut()
                }))
            self.present(alert, animated: true, completion: nil)
        }

        optionsView?.optionItem.itemTapped = { [weak self] in
            self?.dismiss(animated: true)
            self?.onDismiss?()
        }
        view = optionsView
    }

}
