import UIKit

class MenuViewController: UIViewController {
    let menuView = MenuView()
    let dataManager = DataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        setButtonAction()
        setDifficult()
        dataManager.spaceshipHP = 4
        dataManager.currentWave = 1
    }
    func setButtonAction() {
        menuView.setButtonActionClosure { [weak self] in
            let gameViewController = GameViewController()
            self?.navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
    func setDifficult() {
        menuView.setEasyButtonActionClosure { [weak self] in
            self?.dataManager.difficult = 1
        }
        menuView.setMiddleButtonActionClosure { [weak self] in
            self?.dataManager.difficult = 2
        }
        menuView.setHardButtonActionClosure { [weak self] in
            self?.dataManager.difficult = 3
        }
    }
}
