//
//  GameMenuViewController.swift
//  108_Tukaev
//
//  Created by surexnx on 23.11.2023.
//

import UIKit

class GameMenuViewController: UIViewController {

    private lazy var customView: GameMenuView = {
        return GameMenuView(frame: .zero)
    }()

    init(score: Int, winLose: String) {
        super.init(nibName: nil, bundle: nil)
        customView.setupMenu(score: score, winLose: winLose)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = customView
        customView.delegate = self
        navigationItem.hidesBackButton = true
    }

}

extension GameMenuViewController: ButtonMenuDelegate {
    func restartButton() {
        navigationController?.popViewController(animated: false)
    }

    func backButton() {
        navigationController?.pushViewController(StartViewController(), animated: false)
    }
}
