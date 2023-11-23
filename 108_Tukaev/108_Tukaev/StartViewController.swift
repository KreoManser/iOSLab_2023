//
//  StartGameViewController.swift
//  108_Tukaev
//
//  Created by surexnx on 23.11.2023.
//

import UIKit

class StartViewController: UIViewController {

    private lazy var customView: StartView = {
        return StartView(frame: .zero)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }

    override func loadView() {
        view = customView
        customView.delegate = self
    }
}
extension StartViewController: StartDelegate {
    func easyGame() {
        customView.clearView()
        navigationController?.pushViewController(GameViewController(lvl: 1), animated: true)
    }

    func hardGame() {
        customView.clearView()
        navigationController?.pushViewController(GameViewController(lvl: 2), animated: true)
    }

    func startGame() {
        customView.clearView()
        navigationController?.pushViewController(GameViewController(lvl: 0), animated: true)
    }
}
