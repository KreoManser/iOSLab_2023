//
//  GameView.swift
//  AlienDestroyer
//
//  Created by Кирилл Щёлоков on 17.11.2023.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func minusHealth(for view: EntityProtocol, from weapon: WeaponProtocol) -> Int
    func increaseScore(score: String) -> String
    func setBestScore(score: String)
    func getScore() -> String
}

class GameView: UIView {

    private lazy var backgroundImageView: UIImageView = UIImageView()
    private lazy var closeButton: UIButton = UIButton()
    private lazy var scoreLabel: UILabel = UILabel()
    private lazy var movePlayerRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(movePlayerHandler))
    private lazy var customPlayerView: CustomPlayerView = CustomPlayerView()
    private lazy var customBossView: CustomBossView = CustomBossView()
    private lazy var winLoseMenu: CustomWinLoseMenu = CustomWinLoseMenu()

    private var playerPosition: CGPoint = .zero

    private var shootingTimer: Timer?
    private var spawnAlienTimer: Timer?
    private var spawnBossTimer: Timer?
    private var shootBossTimer: Timer?
    private var collisionTimer: Timer?
    private var alienArray: [UIView] = []
    private var playerWeaponArray: [UIView] = []
    private var enemyWeaponArray: [UIView] = []
    private var bonusArray: [UIView] = []
    private let diff: (spawnSpeed: Double, enemyAttackSpeed: Double)

    private var bonusCount: Int = 0

    private var initialTouchPoint: CGPoint = .zero

    var homeButtonTapped: (() -> Void)?
    weak var delegate: GameViewDelegate?

    required init(frame: CGRect, diff: (spawnSpeed: Double, enemyAttackSpeed: Double)) {
        self.diff = diff
        super.init(frame: frame)
        addGestureRecognizer(movePlayerRecognizer)
        setUpViews()
        setUpAnimations()
        winLoseMenu.homeButtonTapped = { [weak self] in
            self?.darkenScreen()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        setUpBackgroundImageView()
        setUpCloseButton()
        setUpScoreLabel()
        setUpСustomPlayerView()
        setUpCustomWinLoseMenu()
    }

    private func setUpAnimations() {
        setUpBackgroundAnimation()
        setUpPlayerStartAnimation()
    }

    // MARK: Set Up Views

    private func setUpBackgroundImageView() {
        addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "BackgroundImage")
        backgroundImageView.frame = CGRect(x: -frame.width - 1120, y: -frame.height - 1700, width: bounds.width * 5, height: bounds.height * 4)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
    }

    private func setUpCloseButton() {
        addSubview(closeButton)
        closeButton.setImage(UIImage(named: "exitIcon"), for: .normal)
        closeButton.transform = CGAffineTransform(rotationAngle: .pi)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        let closeAction = UIAction { [weak self] _ in
            self?.darkenScreen()
        }

        closeButton.addAction(closeAction, for: .touchUpInside)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            closeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    private func setUpScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.textColor = .white
        scoreLabel.text = "0"
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 40)

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            scoreLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15)
        ])
    }

    private func setUpСustomPlayerView() {
        addSubview(customPlayerView)
        customPlayerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customPlayerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            customPlayerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 100),
            customPlayerView.heightAnchor.constraint(equalToConstant: 64),
            customPlayerView.widthAnchor.constraint(equalToConstant: 64)
        ])
    }

    private func setUpCustomWinLoseMenu() {
        winLoseMenu.isHidden = true
        addSubview(winLoseMenu)
        winLoseMenu.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            winLoseMenu.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            winLoseMenu.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor, constant: -40),
            winLoseMenu.heightAnchor.constraint(equalToConstant: 400),
            winLoseMenu.widthAnchor.constraint(equalToConstant: 350)
        ])
    }

    // MARK: Set Up Animations

    private func setUpBackgroundAnimation() {
        startBossTimer()
        UIView.animate(withDuration: 120, delay: 0, options: [.curveLinear], animations: { [weak self] in
            self?.backgroundImageView.transform = CGAffineTransform(translationX: 0, y: 2550)
        })
    }

    private func setUpPlayerStartAnimation() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: { [weak self] in
            self?.customPlayerView.transform = CGAffineTransform(translationX: 0, y: -200)
        }, completion: {[weak self] _ in
            self?.startShootingTimer(timeInterval: self?.customPlayerView.atackSpeed ?? 1.5)
            self?.startAlienTimer()
            self?.startCollisionTimer()
        })
    }

    private func playerFlyAwayAnimation() {
        UIView.animate(withDuration: 2, delay: .zero, options: [.curveLinear], animations: { [weak self] in
            self?.customPlayerView.transform = CGAffineTransform(translationX: 0, y: -(self?.bounds.height ?? 500) - 200)
        }, completion: { [weak self] _ in
            self?.showWinLoseMenu(state: "ПОБЕДА!!!")
        })
    }

    private func setExplosionAnimation(for view: UIView) {
        let location = getLocation(for: view)
        if !(view is CustomPlayerView) {
            scoreLabel.text = delegate?.increaseScore(score: scoreLabel.text ?? "0")
            spawnBonus(for: view, location: location)
        }
        var explosionImageView: UIImageView
        if view is CustomBossView {
            explosionImageView = UIImageView(frame: CGRect(x: location.locationX - 64, y: location.locationY - 64, width: 140, height: 140))
        } else {
            explosionImageView = UIImageView(frame: CGRect(x: location.locationX - 20, y: location.locationY - 20, width: 50, height: 50))
        }
        let explosionImages = [
            "ExplosionImage1",
            "ExplosionImage2",
            "ExplosionImage3",
            "ExplosionImage4",
            "ExplosionImage5",
            "ExplosionImage6",
            "ExplosionImage7"]
        view.removeFromSuperview()
        let images = explosionImages.compactMap { UIImage(named: $0) }
        createAnimation(imageView: explosionImageView, images: images, duration: 0.4)
        addSubview(explosionImageView)
    }

    private func createAnimation(imageView: UIImageView, images: [UIImage], duration: TimeInterval) {
        imageView.animationImages = images
        imageView.animationDuration = duration
        imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }

    private func blink(for image: UIView) {
        UIView.animate(withDuration: 0.1, delay: .zero, options: [.curveLinear, .autoreverse], animations: { [weak image] in
            image?.alpha = 0.5
        }, completion: { [weak image] _ in
            image?.alpha = 1
        })
    }

    // MARK: Handling functions

    @objc
    private func movePlayerHandler(_ gesture: UIPanGestureRecognizer) {
        let touchPoint = gesture.location(in: self)
        if gesture.state == .began {
            initialTouchPoint = touchPoint
        } else if gesture.state == .changed {
            let translation = CGAffineTransform(translationX: touchPoint.x - initialTouchPoint.x, y: touchPoint.y - initialTouchPoint.y)
            customPlayerView.transform = customPlayerView.transform.concatenating(translation)

            initialTouchPoint = touchPoint
        }
    }

    private func enemyCollisionHandler(rocket: UIView, alien: UIView) {
        guard let enemy = alien as? EntityProtocol else {return}
        guard let health = delegate?.minusHealth(for: enemy, from: rocket as? WeaponProtocol ?? CustomRocketView()) else {return}
        rocket.removeFromSuperview()
        removeFromArray(array: &playerWeaponArray, subject: rocket)
        blink(for: alien)
        if health == 0 {
            setExplosionAnimation(for: alien)
            removeFromArray(array: &alienArray, subject: alien)
        }
    }

    private func bossCollisionHandler(rocket: UIView, boss: UIView) {
        guard let enemy = boss as? EntityProtocol else {return}
        guard let health = delegate?.minusHealth(for: enemy, from: rocket as? WeaponProtocol ?? CustomRocketView()) else {return}
        rocket.removeFromSuperview()
        removeFromArray(array: &enemyWeaponArray, subject: rocket)
        blink(for: boss)
        if health == 0 {
            setExplosionAnimation(for: boss)
            boss.removeFromSuperview()
            shootingTimer?.invalidate()
            shootBossTimer?.invalidate()
            movePlayerRecognizer.isEnabled = false
            playerFlyAwayAnimation()
        }
    }

    private func playerCollisionHandler(weapon: UIView, player: CustomPlayerView) {
        guard let enemyWeapon = weapon as? WeaponProtocol else { return }
        guard let health = delegate?.minusHealth(for: player, from: enemyWeapon) else {return}
        removeFromArray(array: &playerWeaponArray, subject: weapon)
        weapon.removeFromSuperview()
        blink(for: player)
        if health <= 0 {
            weapon.removeFromSuperview()
            setExplosionAnimation(for: player)
            shootingTimer?.invalidate()
            shootBossTimer?.invalidate()
            movePlayerRecognizer.isEnabled = false
            player.removeFromSuperview()
            showWinLoseMenu(state: "Поражение")
        } else {
            player.updatePlayerHealthState()
        }
    }

    private func bonusCollisionHandler(bonus: UIView) {
        guard let bonus1 = bonus as? LevelUpBonus else { return }
        bonusCount += 1
        customPlayerView.atackSpeed /= bonus1.atackSpeedScale
        shootingTimer?.invalidate()
        startShootingTimer(timeInterval: customPlayerView.atackSpeed)
        bonus.removeFromSuperview()
    }

    // MARK: Timers

    private func startShootingTimer(timeInterval: Double) {
        shootingTimer?.invalidate()
        shootingTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(spawnRocket), userInfo: nil, repeats: true)
    }

    private func startAlienTimer() {
        spawnAlienTimer = Timer.scheduledTimer(timeInterval: diff.spawnSpeed, target: self, selector: #selector(spawnAliens),
            userInfo: nil, repeats: true)
    }

    private func startCollisionTimer() {
        collisionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkCollision), userInfo: nil, repeats: true)
    }

    private func startBossTimer() {
        spawnBossTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(spawnBoss), userInfo: nil, repeats: false)
    }

    // MARK: Spawners

    @objc
    private func spawnRocket() {
        var weapon: UIView
        if bonusCount < 1 {
            weapon = CustomRocketView()
        } else {
            weapon = CustomRocketView()
        }
        playerWeaponArray.append(weapon)
        addSubview(weapon)

        weapon.frame = CGRect(x: customPlayerView.frame.midX - 23, y: customPlayerView.frame.minY, width: 48, height: 48)

        UIView.animate(withDuration: 4, animations: { [weak self, weak weapon] in
            weapon?.transform = CGAffineTransform(translationX: 0, y: -(self?.bounds.height ?? 0) - 80)
        }, completion: { [weak weapon] _ in
            weapon?.removeFromSuperview()
            self.removeFromArray(array: &self.playerWeaponArray, subject: weapon ?? UIView())
        })
    }

    @objc
    private func spawnAliens() {
        let customAlienView = CustomAlienView()
        alienArray.append(customAlienView)
        addSubview(customAlienView)

        let randomX = CGFloat.random(in: 20...(bounds.width - 20))
        customAlienView.frame = CGRect(x: randomX, y: bounds.minY - 10, width: 40, height: 40)
        enemyShoot(for: customAlienView)

        UIView.animate(withDuration: 12, animations: { [weak self] in
            customAlienView.transform = CGAffineTransform(translationX: 0, y: (self?.bounds.height ?? 0) + customAlienView.frame.height)
        }, completion: { [weak customAlienView] _ in
            guard let alien = customAlienView else { return }
            alien.removeFromSuperview()
            self.removeFromArray(array: &self.alienArray, subject: alien)
        })
    }

    @objc
    private func spawnBoss() {
        spawnAlienTimer?.invalidate()
        addSubview(customBossView)

        customBossView.frame = CGRect(x: (bounds.width / 2) - 40, y: -200, width: 80, height: 128)
        bossShoot(for: customBossView)

        UIView.animate(withDuration: 4, animations: { [weak self] in
            self?.customBossView.transform = CGAffineTransform(translationX: 0, y: 250)
        })
    }

    private func enemyShoot(for alien: CustomAlienView) {
        Timer.scheduledTimer(withTimeInterval: diff.enemyAttackSpeed, repeats: true) { [weak self] _ in
            let weapon = CustomEnemyWeaponView()
            guard let location = self?.getLocation(for: alien) else { return }
            weapon.frame = CGRect(x: location.locationX - 10, y: location.locationY, width: 20, height: 20)

            self?.enemyWeaponArray.append(weapon)
            self?.addSubview(weapon)

            UIView.animate(withDuration: 2, delay: .zero, options: [.curveLinear], animations: {
                weapon.transform = CGAffineTransform(translationX: 0, y: (self?.bounds.height ?? 0) + 80)
            }, completion: { _ in
                guard let gameView = self else { return }
                weapon.removeFromSuperview()
                gameView.removeFromArray(array: &gameView.enemyWeaponArray, subject: weapon)
            })
        }
    }

    private func bossShoot(for boss: CustomBossView) {
        shootBossTimer = Timer.scheduledTimer(withTimeInterval: diff.enemyAttackSpeed - 0.5, repeats: true) { [weak self] _ in
            let randomX = CGFloat.random(in: -(self?.bounds.width ?? 0) / 2...((self?.bounds.width ?? 500)) / 2)
            let weapon = CustomBossWeaponView()
            guard let location = self?.getLocation(for: boss) else { return }
            weapon.frame = CGRect(x: location.locationX - 10, y: location.locationY, width: 20, height: 20)

            self?.enemyWeaponArray.append(weapon)
            self?.addSubview(weapon)

            UIView.animate(withDuration: 3, delay: .zero, options: [.curveLinear], animations: {
                weapon.transform = CGAffineTransform(translationX: randomX, y: (self?.bounds.height ?? 0) + 80)
            }, completion: { _ in
                guard let gameView = self else { return }
                weapon.removeFromSuperview()
                gameView.removeFromArray(array: &gameView.enemyWeaponArray, subject: weapon)
            })
        }
    }

    private func spawnBonus(for alien: UIView, location: (locationX: CGFloat, locationY: CGFloat)) {
        let random = Int.random(in: 0...2)
        if random == 1 {
            let levelUpBonusView = LevelUpBonus()
            addSubview(levelUpBonusView)
            bonusArray.append(levelUpBonusView)

            levelUpBonusView.frame = CGRect(x: location.locationX, y: location.locationY, width: 40, height: 40)

            UIView.animate(withDuration: 12, animations: { [weak self] in
                levelUpBonusView.transform = CGAffineTransform(translationX: 0, y: (self?.bounds.height ?? 0) + levelUpBonusView.frame.height)
            }, completion: { [weak levelUpBonusView] _ in
                guard let bonus = levelUpBonusView else { return }
                bonus.removeFromSuperview()
                self.removeFromArray(array: &self.bonusArray, subject: bonus)
            })
        }
    }

    // MARK: Helping functions

    private func removeFromArray(array: inout [UIView], subject: UIView) {
        if let index = array.firstIndex(of: subject) {
            array.remove(at: index)
        }
    }

    @objc
    private func checkCollision() {
        for rocketView in playerWeaponArray {
            for alienView in alienArray where rocketView.layer.presentation()?.frame.intersects(alienView.layer.presentation()?.frame ?? .zero)
            ?? false {
                enemyCollisionHandler(rocket: rocketView, alien: alienView)
            }
            guard let bool = rocketView.layer.presentation()?.frame.intersects(customBossView.layer.presentation()?.frame ?? .zero)
            else { return }
            if bool {
                bossCollisionHandler(rocket: rocketView, boss: customBossView)
            }
        }
        checkPlayerCollision(forWeapons: enemyWeaponArray)
        checkBonusCollision(forBonuses: bonusArray)
    }

    private func checkPlayerCollision(forWeapons array: [UIView]) {
        for weapon in array {
            var bool: Bool = false
            if let weapon1 = weapon as? CustomEnemyWeaponView {
                bool = weapon1.layer.presentation()?.frame.intersects(customPlayerView.layer.presentation()?.frame ?? .zero) ?? false
            } else if let weapon2 = weapon as? CustomBossWeaponView {
                bool = weapon2.layer.presentation()?.frame.intersects(customPlayerView.layer.presentation()?.frame ?? .zero) ?? false
            }
            if bool {
                playerCollisionHandler(weapon: weapon, player: customPlayerView)
            }
        }
    }

    private func checkBonusCollision(forBonuses array: [UIView]) {
        for bonus in array {
            var bool: Bool = false
            if let levelUp = bonus as? LevelUpBonus {
                bool = levelUp.layer.presentation()?.frame.intersects(customPlayerView.layer.presentation()?.frame ?? .zero) ?? false
            }
            if bool {
                bonusCollisionHandler(bonus: bonus)
            }
        }
    }

    private func darkenScreen() {
        let darkView = UIView(frame: bounds)
        darkView.tag = 999
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
        addSubview(darkView)

        UIView.animate(withDuration: 1.5, delay: .zero, options: [.curveLinear], animations: {
            darkView.backgroundColor = UIColor.black.withAlphaComponent(1)
        }, completion: { [weak self] _ in
            self?.homeButtonTapped?()
            UIView.animate(withDuration: 1.5, delay: .zero, options: [.curveLinear], animations: {
                darkView.backgroundColor = UIColor.black.withAlphaComponent(0)
            }, completion: { _ in
                darkView.removeFromSuperview()
            })
        })
    }

    private func showWinLoseMenu(state: String) {
        winLoseMenu.menuLabel.text = state
        winLoseMenu.scoreLabel.text = scoreLabel.text
        delegate?.setBestScore(score: scoreLabel.text ?? "0")
        winLoseMenu.isHidden = false
    }

    private func getLocation(for view: UIView) -> (locationX: CGFloat, locationY: CGFloat) {
        return (view.layer.presentation()?.frame.midX ?? .zero, view.layer.presentation()?.frame.maxY ?? .zero)
    }
}
