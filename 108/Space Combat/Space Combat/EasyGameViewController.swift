import UIKit

class EasyGameViewController: UIViewController {

    var isFirstTap = true
    let randomInterval = Double.random(in: 1.0...10.0)

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
//      массив вражеского огня
    var fireInvader: [UIImageView] = []
//      массив огня корабля
    var fireShip: [UIImageView] = []
//      массив бустов
    var boosts: [UIImageView] = []
//      активный босс
    var invaderBoss: InvaderBoss?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .black

        //      добавление функции жеста кораблю
        let shipPanGesture = UIPanGestureRecognizer(target: self, action: #selector(shipHandlePan(_:)))
        shipImageView.addGestureRecognizer(shipPanGesture)

        //        создание огня корабля (при нажатии на любое место экрана)
        let shipsFireTapGesture = UITapGestureRecognizer(target: self, action: #selector(createShipFire))
        view.addGestureRecognizer(shipsFireTapGesture)

        //      таймер для проверки столкновения игрока и противника
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shipAndInvadersFireHandleCollision), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shipAndInvadersHandleCollision), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(firesHandleCollision), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shipsFireAndInvadersHandleCollision), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(getBoss), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shipsFireAndBossHandleCollision), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(animateBossFair), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: randomInterval, target: self, selector: #selector(getBoost), userInfo: nil, repeats: false)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(shipAndBoostHandleCollision), userInfo: nil, repeats: true)
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
            }, completion: { _ in
                if let index = self.invaders.firstIndex(of: i) {
                    self.invaders.remove(at: index)
                }
                i.removeFromSuperview()
            })
            delay += 5
        }
    }

//      создание огня пришельца
    @objc func fireFromInvader(_ invader: UIImageView, withDelay delay: TimeInterval) {
        let xValue = invader.frame.origin.x
        let yValue = invader.frame.origin.y

        let fire = UIImageView(image: UIImage(named: "fireAlien"))
        fire.frame = CGRect(x: xValue, y: yValue, width: 90, height: 80)

        self.fireInvader.append(fire)
        view.addSubview(fire)

        UIView.animate(withDuration: 6.0, delay: delay, options: [.curveLinear], animations: {
            fire.center = CGPoint(x: fire.center.x, y: fire.center.y + 800)
        }, completion: { _ in
            if let index = self.fireInvader.firstIndex(of: fire) {
                self.fireInvader.remove(at: index)
            }
            fire.removeFromSuperview()
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

//    следит за столкновением корабля и вражеского огня
    @objc func shipAndInvadersFireHandleCollision() {
        for fire in fireInvader where fire.layer.presentation()?.frame.intersects(shipImageView.layer.presentation()?.frame ?? .zero) == true {
            endAnimation(object: fire)
            gameLost()
        }
    }
//    следит за столкновением корабля и пришельца
    @objc func shipAndInvadersHandleCollision() {
        for i in invaders where i.layer.presentation()?.frame.intersects(shipImageView.layer.presentation()?.frame ?? .zero) == true {
            endAnimation(object: i)
            gameLost()
        }
    }
//    следит за столкновением огня корабля и  огня пришельца
    @objc func firesHandleCollision() {
        for shipsFire in fireShip {
            for invFire in fireInvader where shipsFire.layer.presentation()?.frame.intersects(invFire.layer.presentation()?.frame ?? .zero) == true {
                endAnimation(object: shipsFire)
                fireShip.removeAll { $0 == shipsFire }
                fireInvader.removeAll { $0 == invFire }
                shipsFire.removeFromSuperview()
                invFire.removeFromSuperview()
            }
        }
    }
//    следит за столкновением огня корабля и пришельца
    @objc func shipsFireAndInvadersHandleCollision() {
        for shipsFire in fireShip {
            for invader in invaders where shipsFire.layer.presentation()?.frame.intersects(invader.layer.presentation()?.frame ?? .zero) == true {
                endAnimation(object: shipsFire)
                fireShip.removeAll { $0 == shipsFire }
                invaders.removeAll { $0 == invader }
                shipsFire.removeFromSuperview()
                invader.removeFromSuperview()
            }
        }
    }
//    следит за столкновением огня корабля и босса
    @objc func shipsFireAndBossHandleCollision() {
        guard let invBoss = invaderBoss else {
            return
        }
        for shipsFire in fireShip
        where shipsFire.layer.presentation()?.frame.intersects(invaderBoss?.image.layer.presentation()?.frame ?? .zero) == true {
            invaderBoss?.health -= 1
            shipsFire.removeFromSuperview()
            if invaderBoss?.health == 0 {
                endAnimation(object: shipsFire)
                fireShip.removeAll { $0 == shipsFire }
                invaderBoss?.image.removeFromSuperview()
                gameWin()
            }
        }
    }
//    следит за столкновением корабля и буста
    @objc func shipAndBoostHandleCollision() {
        if !boosts.isEmpty {
            for boost in boosts where boost.layer.presentation()?.frame.intersects(shipImageView.layer.presentation()?.frame ?? .zero) == true {
                boost.removeFromSuperview()
                UIView.animate(withDuration: 0.1, delay: 0, options: [.curveLinear], animations: { [self] in
                    shipImageView.frame = CGRect(x: shipImageView.center.x, y: shipImageView.center.y, width: 60, height: 60)
                }, completion: { _ in
                    self.boosts.removeAll { $0 == boost }
                })
            }
        }
    }

//    следит за прогрессом - если все простые пришельцы уничтожены вызывается босс уровня easy
    @objc func getBoss() {
        if !isFirstTap {
            if invaders.isEmpty && fireInvader.isEmpty {
                createBoss()
            }
        }
    }

//    анимации при столкновении
    func endAnimation(object: UIImageView) {
        UIView.animate(withDuration: 3.0, animations: {
            let transform = CGAffineTransform(scaleX: 100.0, y: 100.0)
            object.transform = transform
        }, completion: { _ in
            object.transform = .identity
        })
        return
    }

//      функция для показа алерт если проигрыш
    func gameLost() {
        let alertController = UIAlertController(title: "Game Over", message: "Вы проиграли", preferredStyle: .alert)
        fireShip.removeAll()
        fireInvader.removeAll()
        invaders.removeAll()
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

//    функция для показа алерт если победа
    func gameWin() {
        let alertController = UIAlertController(title: "Game Over", message: "ВЫ ПОБЕДИЛИ!!!", preferredStyle: .alert)
        fireShip.removeAll()
        fireInvader.removeAll()
        let okAction = UIAlertAction(title: "СУПЕР", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let backAction = UIAlertAction(title: "ОБРАТНО", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let launchAction = UIAlertAction(title: "В ЛАУНЧЕР", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        alertController.addAction(backAction)
        alertController.addAction(launchAction)

        present(alertController, animated: true, completion: nil)
    }

//     функция вызываемая при нажатии 1 раз на экран
    func oneHandleTap() {
        createShip()
        createInvaders()
        animateInvader()
    }

//    создание огня корабля (нажимать на любое место)
    @objc func createShipFire() {
        if isFirstTap {
            oneHandleTap()
            isFirstTap = false
            return
        }
        let shipsFire = UIImageView(image: UIImage(named: "fireShip"))

        let xValue = shipImageView.frame.origin.x
        let yValue = shipImageView.frame.origin.y

        shipsFire.frame = CGRect(x: xValue, y: yValue, width: 90, height: 60)
        self.fireShip.append(shipsFire)
        view.addSubview(shipsFire)

        UIView.animate(withDuration: 6.0, delay: 0, options: [.curveLinear], animations: {
            shipsFire.center = CGPoint(x: shipsFire.center.x, y: -(shipsFire.center.y + 800))
        }, completion: { _ in
            if let index = self.fireShip.firstIndex(of: shipsFire) {
                self.fireShip.remove(at: index)
            }
            shipsFire.removeFromSuperview()
        })
    }

//    инициализация босса
    func createBoss() {
        if let invBoss = invaderBoss {
            return
        }
        invaderBoss = InvaderBoss(health: 2, image: UIImageView(image: UIImage(named: "alien")))
        let randomX = CGFloat.random(in: 180...(UIScreen.main.bounds.width - 180))
        guard let image = invaderBoss?.image else {
            return
        }
        image.frame = CGRect(x: randomX, y: -70, width: 220, height: 160)

        view.addSubview(image)

        UIView.animate(withDuration: 8.0, delay: 0, options: [.curveLinear], animations: { [self] in
            invaderBoss?.image.frame.origin.y = self.view.bounds.height
        }, completion: { _ in
            image.removeFromSuperview()
        })
    }

//    создании и анимировании огня босса
    @objc func animateBossFair() {
        guard let boss = invaderBoss else {
            return
        }
        if boss.health > 0 {

            let fire = UIImageView(image: UIImage(named: "fireAlien"))

            let xValue = CGFloat.random(in: 100...(UIScreen.main.bounds.width - 100))
            let yValue = boss.image.layer.presentation()?.frame.midY ?? 0

            fire.frame = CGRect(x: xValue, y: yValue, width: 130, height: 90)
            self.fireInvader.append(fire)
            view.addSubview(fire)
            UIView.animate(withDuration: 3.0, delay: 0, options: [.curveLinear], animations: {
                fire.frame.origin.y = self.view.bounds.height
            }, completion: { _ in
                if let index = self.fireInvader.firstIndex(of: fire) {
                    self.fireInvader.remove(at: index)
                }
                fire.removeFromSuperview()
            })
        }
    }

//    функция для создании буста (в рандомный момент буст падает - уменьшает размер корабля для бОльшего и быстрого маневра)
    @objc func getBoost() {
        if isFirstTap {
            return
        }
        let boost = UIImageView(image: UIImage(named: "star"))

        let randomX = CGFloat.random(in: 130...(UIScreen.main.bounds.width - 130))
        boost.frame = CGRect(x: randomX, y: -70, width: 90, height: 70)

        self.boosts.append(boost)
        view.addSubview(boost)

        UIView.animate(withDuration: 4.0, delay: 0, options: [.curveLinear], animations: {
            boost.center = CGPoint(x: boost.center.x, y: boost.center.y + 800)
        }, completion: { _ in
            if let index = self.boosts.firstIndex(of: boost) {
                self.boosts.remove(at: index)
            }
            boost.removeFromSuperview()
        })
    }

}
