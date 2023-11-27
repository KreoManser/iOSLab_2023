//
//  MenuViewController.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 21.11.2023.
//

import UIKit

class MenuViewController: UIViewController {
    var menuView = MenuView(frame: .zero)
    var countForChioceLevel: Int = 0
    override func loadView() {
        view = menuView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.menuController = self
    }
    
    func choiceLevel(defoultLevel: String ) -> String {
        let levels = Manager.shared.getLevels()
        if defoultLevel == "Easy" {
            countForChioceLevel += 1
            return levels[countForChioceLevel]
        }
        if countForChioceLevel <= 2 {
            let level = levels[countForChioceLevel]
            countForChioceLevel += 1
            return level
        } else {
            countForChioceLevel = 0
            return levels[countForChioceLevel]
        }
    }

    func beganGame(level: String) {
        let gameController = GameViewController()
        gameController.levelGameDelegate = level
        navigationController?.pushViewController(gameController, animated: false)
    }



}
