import UIKit
class GameView: UIView {
    var spaceship: Spaceship = Spaceship()
    var bulletSpaceshipTimer: Timer?
    var checkTimer: Timer?
    var backgroundImageView: UIImageView = UIImageView()
    var bulletsSpaceshipList: [Bullet] = []
    var aliensList: [(Alien, [AlienBullet])] = []
    var heartImageViews: [UIImageView] = []
    var heartImageView: UIImageView = UIImageView()
    var speedImageView: UIImageView = UIImageView()
    var timeInterval: TimeInterval
    weak var delegate: GameViewDelegate?
    override init(frame: CGRect) {
        timeInterval = 1.0
        super.init(frame: frame)
        backgroundColor = .systemBlue
        createShip()
        startBulletSpaceshipTimer(timeInterval: timeInterval)
        setupBackground()
        animateBackground()
        startCheckSpaceshipHitsAliensTimer()
        startCheckAlienHitsSpaceshipTimer()
        addHeartImageViews(heartCount: 5)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Background
    func setupBackground() {
        backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        let expandedFrame = CGRect(x: -bounds.width, y: -bounds.height, width: bounds.width * 3, height: bounds.height * 3)
        backgroundImageView.frame = expandedFrame
        backgroundImageView.image = UIImage(named: "space.2")
        addSubview(backgroundImageView)
        sendSubviewToBack(backgroundImageView)
    }
    func animateBackground() {
        let duration: TimeInterval = 180.0
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .repeat], animations: {
            self.backgroundImageView.frame.origin.y = self.bounds.height
        }, completion: { _ in
            self.backgroundImageView.frame.origin.y = 0
            self.animateBackground()
        })
    }
    // MARK: Spaceship
    func createShip() {
        addSubview(spaceship)
        spaceship.frame = CGRect(x: (self.frame.width - 50) / 2, y: self.frame.height - 100, width: 50, height: 50)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didMove(_:)))
        spaceship.addGestureRecognizer(panGesture)
    }
    /// Gesture
    @objc func didMove(_ gesture: UIPanGestureRecognizer) {
        guard let superview = self.superview else { return }
        let translation = gesture.translation(in: superview)
        let newX = spaceship.center.x + translation.x
        let maxX = superview.safeAreaLayoutGuide.layoutFrame.maxX - spaceship.bounds.width / 2
        let minX = superview.safeAreaLayoutGuide.layoutFrame.minX + spaceship.bounds.width / 2
        spaceship.center.x = max(minX, min(maxX, newX))
        gesture.setTranslation(.zero, in: superview)
    }
    ///  Spaceship Bullet
    func startBulletSpaceshipTimer(timeInterval: TimeInterval) {
        bulletSpaceshipTimer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(createSpaceshipBullet),
            userInfo: nil,
            repeats: true)
    }
    @objc func createSpaceshipBullet() {
        let bullet = Bullet()
        bullet.isUserInteractionEnabled = true
        bullet.center.x = spaceship.center.x
        bullet.center.y = spaceship.center.y - 60
        bullet.bounds.size = CGSize(width: 30, height: 30)
        self.addSubview(bullet)
        createBang(x: spaceship.center.x - 26, y: spaceship.center.y - 50)
        bulletsSpaceshipList.append(bullet)
        UIView.animate(withDuration: 1.5, animations: {
            bullet.frame.origin.y -= 1000
        }, completion: { _ in
            bullet.removeFromSuperview()
            self.bulletsSpaceshipList.removeAll { $0 === bullet }
        })
    }
    /// Spaceship hit aliens
    func startCheckSpaceshipHitsAliensTimer() {
        checkTimer = Timer.scheduledTimer(
            timeInterval: 0.001,
            target: self,
            selector: #selector(checkSpaceshipHitAlien),
            userInfo: nil,
            repeats: true)
    }
    @objc
    private func checkSpaceshipHitAlien() {
        for bullet in bulletsSpaceshipList {
            for alien in aliensList {
                let bulletFrame = bullet.layer.presentation()?.frame ?? .zero
                let alienFrame = alien.0.layer.presentation()?.frame ?? .zero
                if bulletFrame.intersects(alienFrame) {
                    changesAfterSpaceshipHitAlien(bullet: bullet, alien: alien.0)
                }
            }
        }
    }
    private func changesAfterSpaceshipHitAlien(bullet: Bullet, alien: Alien) {
        createBang(x: alien.center.x - 20, y: alien.center.y)
        bullet.removeFromSuperview()
        if let index = aliensList.firstIndex(where: { $0.0 == alien }) {
            if alien.health > 0 {
                alien.health -= 1
            } else {
                aliensList[index].1.forEach { bullet in
                    bullet.removeFromSuperview()
                }
                aliensList[index].1.removeAll()

                let animator = UIViewPropertyAnimator(duration: 0.7, curve: .linear) {
                    alien.transform = CGAffineTransform(rotationAngle: .pi)
                    alien.transform = alien.transform.scaledBy(x: 0.5, y: 0.5)
                }
                animator.addAnimations {
                    alien.frame.origin.y = -alien.frame.height
                }
                animator.startAnimation()
                animator.addCompletion { _ in
                    alien.removeFromSuperview()
                }
                clearMemoryOfAliens(bullet: bullet, alien: alien)
            }
        }
    }
    /// Remove items after hit
    private func clearMemoryOfAliens(bullet: Bullet, alien: Alien) {
        if let index = self.bulletsSpaceshipList.firstIndex(of: bullet) {
            self.bulletsSpaceshipList.remove(at: index)
        }
        if let index = self.aliensList.firstIndex(where: { $0.0 == alien }) {
            self.aliensList.remove(at: index)
        }
    }
    // MARK: Aliens
    func createAliens(shipCount: Int, alienImage: String, height: CGFloat, health: Int, bulletSpeed: CGFloat) {
        let shipSize = CGSize(width: 50, height: height)
        let shipSpacing: CGFloat = 30
        let startX = (self.frame.width - (CGFloat(shipCount) * shipSize.width + CGFloat(shipCount - 1) * shipSpacing)) / 2
        let startY: CGFloat = -200
        let bullets: [AlienBullet] = []
        for index in 0..<shipCount {
            let alien = Alien(currentAlien: alienImage, height: height, width: 50, health: health, bulletSpeed: bulletSpeed)
            alien.frame = CGRect(x: startX + CGFloat(index) * (shipSize.width + shipSpacing), y: startY, width: 50, height: height)
            self.addSubview(alien)
            aliensList.append((alien, bullets))
            animateAlienShip(alien: alien)
        }
    }
    func animateAlienShip(alien: Alien) {
        let duration: TimeInterval = 1.0
        _ = aliensList.firstIndex(where: { $0.0 == alien })
        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear], animations: {
            alien.frame.origin.y += 400
        }, completion: { _ in
            self.startBulletAlienTimer(alien: alien)
        })
    }
    /// Alien bullet
    func startBulletAlienTimer(alien: Alien) {
        _ = Timer.scheduledTimer(
            timeInterval: alien.bulletSpeed,
            target: self,
            selector: #selector(createBulletAlien(_:)),
            userInfo: ["alien": alien],
            repeats: true)
    }
    @objc func createBulletAlien(_ timer: Timer) {
        if aliensList.count > 0 {
            guard let userInfo = timer.userInfo as? [String: Any],
            let alien = userInfo["alien"] as? Alien else {
                return
            }
            guard self.subviews.contains(alien) else {
                timer.invalidate()
                return
            }
            guard aliensList.contains(where: { $0.0 === alien }) else {
                timer.invalidate()
                return
            }
            let bullet = AlienBullet()
            bullet.isUserInteractionEnabled = true
            bullet.center.x = alien.center.x
            bullet.center.y = alien.center.y + 20
            bullet.bounds.size = CGSize(width: 30, height: 30)
            self.addSubview(bullet)
            let index = aliensList.firstIndex(where: { $0.0 === alien })
            createBang(x: alien.center.x - 25, y: alien.center.y)
            aliensList[index ?? 0].1.append(bullet)
            UIView.animate(withDuration: 1.5, animations: {
                bullet.frame.origin.y += 1000
            }, completion: { _ in
            })
        } else {
            return
        }
    }
    /// Aliens hit spaceship
    func startCheckAlienHitsSpaceshipTimer() {
        checkTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(checkAlienHitSpaceship), userInfo: nil, repeats: true)
    }
    @objc private func checkAlienHitSpaceship() {
        for (alien, bullets) in aliensList {
            for bullet in bullets {
                let bulletFrame = bullet.layer.presentation()?.frame ?? .zero
                let spaceshipFrame = spaceship.layer.presentation()?.frame ?? .zero
                if bulletFrame.intersects(spaceshipFrame) {
                    changesAfterAlienHitSpaceship(bullet: bullet, alien: alien)
                }
            }
        }
        delegate?.checkAliensKilled()
    }
    private func changesAfterAlienHitSpaceship(bullet: AlienBullet, alien: Alien) {
        print("попал")
        heartImageViews[heartImageViews.count - 1].removeFromSuperview()
        heartImageViews.remove(at: heartImageViews.count - 1)
        bullet.removeFromSuperview()
        delegate?.hitShip()
    }
    /// Remove items after hit
    private func removeAlienFromArrays(bullet: AlienBullet, alien: Alien) {
        if let index = self.aliensList.firstIndex(where: { $0.0 === alien }) {
            self.aliensList[index].1.removeAll()
            self.aliensList.remove(at: index)
        }
    }
    // MARK: Bang
    func createBang(x: CGFloat, y: CGFloat) {
        let fireEfx = UIImageView(frame: CGRect(x: x, y: y, width: 50, height: 50))
        let imageNames = ["bang1.1", "bang1.2", "bang1.3", "bang1.4"]
        let images = imageNames.compactMap { UIImage(named: $0) }
        animateImage(imageView: fireEfx, images: images, duration: 0.25)
        self.addSubview(fireEfx)
    }
    func animateImage(imageView: UIImageView, images: [UIImage], duration: TimeInterval) {
        imageView.animationImages = images
        imageView.animationDuration = duration
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }
    // MARK: Upgrades
    func startCheckSpaceshipGetUpgradeTimer() {
        checkTimer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(checkSpaceshipGetHP),
            userInfo: nil,
            repeats: true)
        checkTimer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(checkSpaceshipAdditionalBullet),
            userInfo: nil,
            repeats: true)
    }
    /// HP
    func getHP() {
        let heartSize: CGFloat = 50
        let startY = bounds.minY
        heartImageView = UIImageView(
            frame: CGRect(
                x: bounds.width / 2 - 100,
                y: startY, width: heartSize, height: heartSize))
        heartImageView.image = UIImage(named: "heart")
        addSubview(heartImageView)
        UIView.animate(withDuration: 7, delay: 0, options: [.curveLinear], animations: {
            self.startCheckSpaceshipGetUpgradeTimer()
            self.heartImageView.frame.origin.y += 2000
        }, completion: { _ in
            self.heartImageView.removeFromSuperview()
        })
    }
    @objc
    private func checkSpaceshipGetHP() {
        let heartImageFrame = heartImageView.layer.presentation()?.frame ?? .zero
        let spaceshipFrame = spaceship.layer.presentation()?.frame ?? .zero
        if heartImageFrame.intersects(spaceshipFrame) {
            heartImageView.removeFromSuperview()
            delegate?.addHP()
            addHeartImageViews(heartCount: heartImageViews.count + 1)
        }
    }
    func addHeartImageViews(heartCount: Int) {
        let heartSize: CGFloat = 30
        let heartSpacing: CGFloat = 10
        let startX = bounds.minX + 10
        let startY = bounds.minY + 60
        heartImageViews.forEach { $0.removeFromSuperview() }
        heartImageViews.removeAll()
        for i in 0..<heartCount {
            let heartImageView = UIImageView(frame: CGRect(
                x: startX + CGFloat(i) * (heartSize + heartSpacing),
                y: startY,
                width: heartSize,
                height: heartSize))
            heartImageView.image = UIImage(named: "heart")
            addSubview(heartImageView)
            heartImageViews.append(heartImageView) }
    }
    /// Additional Bullet
    func getAdditionalBullet() {
        let startY = bounds.minY
        speedImageView = UIImageView(
            frame: CGRect(
                x: bounds.width / 2 + 100,
                y: startY, width: 50, height: 50))
        speedImageView.image = UIImage(named: "double")
        addSubview(speedImageView)
        UIView.animate(withDuration: 7, delay: 0, options: [.curveLinear], animations: {
            self.startCheckSpaceshipGetUpgradeTimer()
            self.speedImageView.frame.origin.y += 2000
        }, completion: { _ in
            self.speedImageView.removeFromSuperview()
        })
    }
    @objc
    private func checkSpaceshipAdditionalBullet() {
        let speedImageFrame = speedImageView.layer.presentation()?.frame ?? .zero
        let spaceshipFrame = spaceship.layer.presentation()?.frame ?? .zero
        if speedImageFrame.intersects(spaceshipFrame) {
            speedImageView.removeFromSuperview()
            startBulletSpaceshipTimer(timeInterval: timeInterval)
        }
    }
}
