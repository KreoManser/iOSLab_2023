//
//  StartViewController.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 21.11.2023.
//

import UIKit

class StartViewController: UIViewController {
    var startView: StartView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        startView?.startButton.addTarget(self, action: #selector(startButtontapped), for: .touchUpInside)
        startView?.startButtonTapped  = { [weak self] in
            let gameViewController = GameViewController()
            self?.navigationController?.pushViewController(gameViewController, animated: true)

        }
    }
    private func setUpView() {
        startView = StartView(frame: view.bounds)
        view = startView

    }
    @objc private func startButtontapped() {
        startView?.startButtonTapped!()
    }
}
