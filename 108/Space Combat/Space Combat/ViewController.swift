import UIKit

class ViewController: UIViewController {

//      космический корабль
    var shipImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "ship")
        image.isUserInteractionEnabled = true
        return image
    }()
//      массив пришельцев
    var invaders: [UIImageView] = []
    var fireInvader: [UIImageView] = []
    var fireShip: [UIImageView] = []

    //    var fireShipImageView: UIImageView = {
    //        let image = UIImageView()
    //        image.translatesAutoresizingMaskIntoConstraints = false
    //        image.image = UIImage(named: "fireShip")
    //        return image
    //    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        createShip()
        createInvaders()
        animateInvader()

//      добавление функции жеста кораблю
        let shipPanGesture = UIPanGestureRecognizer(target: self, action: #selector(shipHandlePan(_:)))
        shipImageView.addGestureRecognizer(shipPanGesture)
//      таймер для проверки столкновения корабля и вражеского огня
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCollision), userInfo: nil, repeats: true)
    }

//      инициализация корабля
    func createShip() {
        shipImageView.frame = CGRect(x: view.bounds.width / 2 - 50, y: view.bounds.height - 200, width: 100, height: 100)
        view.addSubview(shipImageView)
    }
//      инициализация пришельцев
    func createInvaders() {
        for _ in 0..<5 {
            let invader = UIImageView(image: UIImage(named: "alien"))
            let randomX = CGFloat.random(in: 0...(UIScreen.main.bounds.width - 80))
            invader.frame = CGRect(x: randomX, y: -70, width: 90, height: 65)
            invaders.append(invader)
        }
    }
//      анимирование пришельцев
    func animateInvader() {
        var delay: TimeInterval = 1.0

        for i in invaders {
            view.addSubview(i)
            fireFromInvader(i, withDelay: delay)
            UIView.animate(withDuration: 10.0, delay: delay, options: [.curveLinear], animations: { [self] in
                i.frame.origin.y = self.view.bounds.height
            })
            delay += 5
        }
    }
//      создание огня пришельца
    func fireFromInvader(_ invader: UIImageView, withDelay delay: TimeInterval) {
        let xValue = invader.frame.origin.x
        let yValue = invader.frame.origin.y
        let fire = UIImageView(image: UIImage(named: "fireAlien"))
        fire.frame = CGRect(x: xValue, y: yValue, width: 90, height: 80)

        view.addSubview(fire)
        fireInvader.append(fire)

        UIView.animate(withDuration: 6.0, delay: delay, options: [.curveLinear], animations: {
            self.fireInvader.removeAll { $0 == fire }
            fire.frame.origin.y = self.view.bounds.height
            self.fireInvader.append(fire)
        }, completion: { _ in
            fire.removeFromSuperview()
            self.fireInvader.removeAll { $0 == fire }
        })
    }
//      перемещение корабля жестом
    @objc func shipHandlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        if let shipView = sender.view {
            shipView.center = CGPoint(x: shipView.center.x + translation.x, y: shipView.center.y)
        }
        sender.setTranslation(CGPoint.zero, in: view)
    }
//      проверка столкновения корабля с вражеским огнем
    @objc func checkCollision() {
        let shipRect = shipImageView.frame
        print("!!!ship Rect: \(shipRect)")

        for fire in fireInvader {
            let fireRect = fire.frame
            print("***fire Rect: \(fireRect)")

            if shipRect.intersects(fireRect) {
                UIView.animate(withDuration: 4.0, animations: {
                    let transform = CGAffineTransform(scaleX: 10.0, y: 10.0)
                    fire.transform = transform
                }, completion: { [self] _ in
                    gameLost()
                })
                return
            }
        }
    }
//      функция для показа алерт если проигрыш
    func gameLost() {
        let alertController = UIAlertController(title: "Game Over", message: "Вы проиграли", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        present(alertController, animated: true, completion: nil)
    }

}
