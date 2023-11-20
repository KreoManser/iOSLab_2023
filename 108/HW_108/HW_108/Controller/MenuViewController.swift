import UIKit

class MenuViewController: UIViewController {
    let menuView = MenuView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        setButtonAction()
    }
    func setButtonAction() {
        menuView.setButtonActionClosure { [weak self] in
            let gameViewController = GameViewController()
            self?.navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
    var findSquare = { (num: Int) -> (Int) in
        var square = num * num
        return square
    }

}
