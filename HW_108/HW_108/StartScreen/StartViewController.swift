//
//  StartViewController.swift
//  HW_108
//
//  Created by Азат Зиганшин on 20.11.2023.
//

import UIKit

class StartViewController: UIViewController {

    var startView = StartView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view = startView
        startView.controller = self
    }

    func presentGame() {
        let gameViewController = GameViewController()
        gameViewController.modalPresentationStyle = .fullScreen
        present(gameViewController, animated: true, completion: nil)
    }
}
