//
//  MainView.swift
//  CosmoStars
//
//  Created by Mac on 2023-11-19.
//

import UIKit

class MainView: UIView {
    // MARK: - Declaration objects
    private lazy var alienShipsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var userShipView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "user"))
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        image.addGestureRecognizer(panGesture)
        return image
    }()

    private var currentUserPosition: CGPoint = CGPoint(x: 0, y: 0)
    private var currentUser = User(.noob)
    private var currentAliens: [Alien] = []
    private var userLevel = 0
    private var aliensLevel = 0
    private var needBoss = true
    private var lastTap: Date?
    private var timerShooter: Timer?
    private var timerAlien: Timer?

    // MARK: - Init
    init(_ frame: CGRect, _ alienLevel: Int, _ userLevel: Int) {
        super.init(frame: frame)
        setupLayouts()
        setupUser(userLevel)
        setupAlienShipsView(alienLevel, false)
        setupBackground()
        showLevel()
        setupTap()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Main View
extension MainView {
    private func setupAlienShipsView(_ level: Int, _ isBoss: Bool) {
        let alien = Alien(.noob)
        aliensLevel = level
        if isBoss {
            switch level {
            case 2:
                currentAliens = alien.createAmountOfAliens(type: .middle, amount: 1)
            case 3:
                currentAliens = alien.createAmountOfAliens(type: .senior, amount: 1)
            case 4...:
                currentAliens = alien.createAmountOfAliens(type: .senior, amount: level)
            default:
                currentAliens = alien.createAmountOfAliens(type: .junior, amount: 1)
            }
        } else {
            switch level {
            case 2:
                currentAliens = alien.createAmountOfAliens(type: .junior, amount: 3)
            case 3:
                currentAliens = alien.createAmountOfAliens(type: .middle, amount: 5)
            case 4...:
                currentAliens = alien.createAmountOfAliens(type: .senior, amount: level - 2)
            default:
                currentAliens = alien.createAmountOfAliens(type: .noob, amount: 2)
            }
        }

        var yConst = 20
        var xConst = 35

        for alien in currentAliens {
            let alienImageView = UIImageView(image: alien.image.image)
            alienImageView.frame = CGRect(x: xConst + Int.random(in: -20...60), y: yConst, width: 70, height: 70)
            alien.alienObject = alienImageView
            alienShipsView.addSubview(alienImageView)
            yConst += 70
            xConst += 50
        }
    }
    private func setupUser(_ level: Int) {
        userLevel = level
        switch level {
        case 2:
            currentUser = User(.junior)
        case 3:
            currentUser = User(.middle)
        case 4:
            currentUser = User(.senior)
        case 4...:
            currentUser.upgradeHero()
        default:
            currentUser = User(.noob)
        }
    }
    private func setupTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(oneTapAction(_:)))
        self.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Constraints
extension MainView {
    private func setupLayouts() {
        addSubview(alienShipsView)
        addSubview(userShipView)

        NSLayoutConstraint.activate([
            alienShipsView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            alienShipsView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            alienShipsView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            alienShipsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            userShipView.topAnchor.constraint(equalTo: alienShipsView.bottomAnchor, constant: -160),
            userShipView.widthAnchor.constraint(equalToConstant: 130),
            userShipView.heightAnchor.constraint(equalToConstant: 160),
            userShipView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }

    private func setupBackground() {
        let backgroundImage = UIImageView(image: UIImage(named: "back"))
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

        addSubview(backgroundImage)
        sendSubviewToBack(backgroundImage)

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - Animate user
extension MainView {
    @objc private func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let changing = recognizer.translation(in: userShipView.superview)

        if recognizer.state == .began {
            currentUserPosition = userShipView.center
            if timerAlien == nil {
                timerAlien = Timer.scheduledTimer(timeInterval: 2,
                target: self, selector: #selector(moveAlienShipsToNewPositions), userInfo: nil, repeats: true)
                timerAlien?.fire()
            }
            if timerShooter == nil {
                timerShooter = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
                    self?.shootAliens()
                }
                timerShooter?.fire()
            }
            if currentAliens.isEmpty {
                timerAlien?.invalidate()
                timerShooter?.invalidate()
            }
        }

        if recognizer.state == .changed {
            let newCenterX = currentUserPosition.x + changing.x
            let minX = userShipView.bounds.width / 2
            let maxX = (superview?.bounds.width ?? 0) - userShipView.bounds.width / 2
            let clampedX = max(minX, min(newCenterX, maxX))
            userShipView.center = CGPoint(x: clampedX, y: currentUserPosition.y)
        }
    }
}

// MARK: - Animate aliens
extension MainView {
    private func animateAlienShips(view: UIView, to position: CGPoint, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            view.frame = CGRect(x: position.x, y: view.frame.minY, width: view.frame.width, height: view.frame.height)
        } completion: { _ in
        }
    }

    @objc private func moveAlienShipsToNewPositions() {
        for alienView in alienShipsView.subviews {
            let newPosition = getNewPositions(view: alienView)
            let durationConst = 3.0 / Double(aliensLevel)
            animateAlienShips(view: alienView, to: newPosition, duration: durationConst)
        }
    }

    private func getNewPositions(view: UIView) -> CGPoint {
        var newPosition: CGPoint
        let const = CGFloat(Int.random(in: -500...500))
        let newX = min(max(view.bounds.width / 2.0 + const, view.bounds.width / 2.0),
            (superview?.bounds.width ?? view.bounds.width / 2.0) - view.bounds.width / 2.0)
        let newY = view.center.y
        newPosition = CGPoint(x: newX, y: newY)
        return newPosition
    }

    private func shootAliens() {
        for alien in currentAliens {
            shootBullet(alien.alienObject ?? UIView(), currentAliens[0])
        }
    }
}

// MARK: - Animate bullets
extension MainView {
    @objc private func oneTapAction(_ gesture: UITapGestureRecognizer) {
        let currentTime = Date()
        let timeConst = 3.0 / Double(userLevel)

        guard let lastTapTime = lastTap else {
            shootBullet(userShipView, currentUser)
            lastTap = currentTime
            return
        }
        if currentTime.timeIntervalSince(lastTapTime) > timeConst {
            shootBullet(userShipView, currentUser)
            lastTap = currentTime
        }
    }

    private func shootBullet(_ shooter: UIView, _ hero: Hero) {
        var animator = UIViewPropertyAnimator()
        let bulletImage = setBullets(shooter, hero)
        alienShipsView.addSubview(bulletImage)

        let startY = shooter.frame.maxY
        let endY = hero.isUser ? -bulletImage.frame.height : UIScreen.main.bounds.height + bulletImage.frame.height
        bulletImage.frame.origin.y = startY

        if hero.amountOfMissiles == 1 {
            animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear) {
                bulletImage.frame.origin.y = endY
            }
        } else if hero.amountOfMissiles >= 3 {
            animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear) {
                bulletImage.frame.origin.y = endY
            }
        }

        animator.addCompletion { [weak self] _ in
            guard let self = self else { return }
            bulletImage.removeFromSuperview()

            if currentAliens.isEmpty && needBoss {
                needBoss = false
                setupUser(userLevel)
                setupAlienShipsView(aliensLevel, true)
                setNeedsLayout()
            } else if currentAliens.isEmpty && !needBoss {
                needBoss = true
                setupUser(userLevel + 1)
                setupAlienShipsView(aliensLevel + 1, false)
                showLevel()
                setNeedsLayout()
            }
        }
        animator.startAnimation()
        if hero.isUser {
            checkHitToAlien(bulletImage, hero)
        } else {
            checkHitToUser(bulletImage, hero)
        }
    }
    private func checkHitToUser(_ bulletImage: UIImageView, _ hero: Hero) {
        var _ = Timer.scheduledTimer(withTimeInterval: 0.01,
        repeats: true, block: { [self] timer in
            if checkCross(getFrame(userShipView), getFrame(bulletImage)) {
                currentUser.health -= Double(hero.damage)
                bulletImage.removeFromSuperview()
                bulletImage.layer.removeAllAnimations()
                if currentUser.health <= 0 {
                    needBoss = true
                    for alien in self.currentAliens {
                        alien.alienObject?.frame.origin.y -= 1000
                        alien.alienObject?.removeFromSuperview()
                    }
                    currentAliens = []
                    setupUser(userLevel)
                    setupAlienShipsView(aliensLevel, false)
                    showLevel("You loose")
                    setNeedsLayout()
                }
                timer.invalidate()
            }
        })
    }

    private func checkHitToAlien(_ bulletImage: UIImageView, _ hero: Hero) {
        var _ = Timer.scheduledTimer(withTimeInterval: 0.01,
        repeats: true, block: { [self] timer in
            for (index, alien) in currentAliens.enumerated() where checkCross(getFrame(alien.alienObject), getFrame(bulletImage)) {
                alien.health -= Double(hero.damage)
                bulletImage.layer.removeAllAnimations()
                bulletImage.removeFromSuperview()
                if !checkHealth(alien) {
                    currentAliens.remove(at: index)
                }
                timer.invalidate()
            }
        })
    }

    private func getFrame(_ view: UIView?) -> CGRect {
        return view?.layer.presentation()?.frame ?? CGRect()
    }

    private func checkCross(_ rect1: CGRect, _ rect2: CGRect) -> Bool {
        return rect1.intersects(rect2)
    }

    private func checkHealth(_ alien: Alien) -> Bool {
        if alien.health <= 0 {
            alien.alienObject?.frame.origin.y -= 1000
            alien.alienObject?.removeFromSuperview()
            return false
        } else { return true }
    }

    private func setBullets(_ shooter: UIView, _ hero: Hero) -> UIImageView {
        var bulletImageView = UIImageView()

        if hero.isUser {
            let user = hero as? User
            switch user?.arm {
            case .blaster:
                bulletImageView = UIImageView(image: UIImage(named: "blasterStar"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.maxY, width: 35, height: 35)
            case .fire:
                bulletImageView = UIImageView(image: UIImage(named: "fireStar"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.maxY, width: 70, height: 60)
            case .galaxy:
                bulletImageView = UIImageView(image: UIImage(named: "meteorStar"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.maxY, width: 90, height: 90)
            case .none:
                bulletImageView = UIImageView(image: UIImage(named: "blasterStar"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.maxY, width: 35, height: 35)
            }
        } else {
            let alien = hero as? Alien
            switch alien?.arm {
            case .blaster:
                bulletImageView = UIImageView(image: UIImage(named: "blaster"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.minY, width: 40, height: 30)
            case .fire:
                bulletImageView = UIImageView(image: UIImage(named: "fire"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.minY, width: 40, height: 40)
            case .meteorite:
                bulletImageView = UIImageView(image: UIImage(named: "meteor"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.minY, width: 45, height: 45)
            case .none:
                bulletImageView = UIImageView(image: UIImage(named: "blaster"))
                bulletImageView.frame = CGRect(x: shooter.center.x, y: shooter.frame.minY, width: 35, height: 35)
            }
        }
        return bulletImageView
    }

    private func showLevel(_ text: String = "") {
        let label = UILabel()
        label.text = text + " Level: \(userLevel)"
        label.numberOfLines = 0
        label.textColor = UIColor.purple
        label.font = UIFont.systemFont(ofSize: 45)
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.alpha = 1.0
        label.layer.cornerRadius = 20
        label.clipsToBounds = true

        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(equalToConstant: 150)
        ])

        UIView.animate(withDuration: 3.0, animations: {
            label.alpha = 0.0
        }, completion: { _ in
            label.removeFromSuperview()
        })
    }
}
