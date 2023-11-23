//
//  GameView.swift
//  108_Tukaev
//
//  Created by surexnx on 21.11.2023.
//

import UIKit

class GameView: UIView {

    var cosmoPlan = UIImageView()
    var centerCosmoPlan: CGPoint?
    var shotingTimer: Timer?
    var evilShotingTImer: Timer?
    var evilInterspects: Timer?
    var evilPlaneShotTimers: [Timer] = []
    var panGestureRecognizer: UIPanGestureRecognizer?

    var interspects: Timer?
    var spawnEvilPlanes: Timer?
    var healthTimer: Timer?
    var counter = 0
    var health = 3

    var evilCosmoPlanes: [EvilPlaneView] = []
    var selfRockets: [Rocket] = []
    var evilRockets: [Rocket] = []
    var controller: GameViewController?

    var lvls: [Lvl] = [Lvl(1, 10, 2, 3), Lvl(2, 10, 2, 3), Lvl(2, 7, 2, 2)]

    var evilHealth: Int = 1
    var evilSpead: Double = 10
    var evilBulletGenerate: Double = 2
    var evilGenerate: Double = 3
    var end: Bool?

    private lazy var backButton: UIButton = {
        var action = UIAction {_ in
            self.controller?.navigationController?.pushViewController(StartViewController(), animated: false)        }
        var button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "flag.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)), for: .normal)

        return button
    }()

    private lazy var counterLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = String(counter)
        label.font = UIFont.systemFont(ofSize: 21)
        return label
    }()

    private lazy var healthLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = String(health)
        label.font = UIFont.systemFont(ofSize: 21)
        return label
    }()

    private lazy var hearthImage: UIImageView = {
        var image = UIImageView(image: UIImage(systemName: "heart.fill"))
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addCosmoPlan()
        startEvilShotTimer()
        startRockets()
        startSpawnEvilPlane()
        startShotIntesects()
        setupLayout()
        stopGame()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addCosmoPlan() {
        cosmoPlan.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 40, y: UIScreen.main.bounds.size.height - 100, width: 80, height: 80)
        cosmoPlan.image = UIImage(named: "cosmoPlane")
        cosmoPlan.isUserInteractionEnabled = true

        self.addSubview(cosmoPlan)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
        guard let pan = panGestureRecognizer else { return }
        cosmoPlan.addGestureRecognizer(pan)
    }

    @objc
    func pan(pgr: UIPanGestureRecognizer) {
        if pgr.state == .began {
            centerCosmoPlan = cosmoPlan.center
        }
        let translation = pgr.translation(in: self)
        guard let centerCosmoPlan = centerCosmoPlan else { return }
        let newCenter = CGPoint(x: centerCosmoPlan.x + translation.x, y: centerCosmoPlan.y + translation.y)

        if newCenter.y < bounds.height && newCenter.y > bounds.height / 2 {
            cosmoPlan.center = newCenter
        }
    }

    @objc
    func shot() {
        let rocket = Rocket()
        rocket.setImage("rocket")
        selfRockets.append(rocket)
        addSubview(rocket)
        rocket.frame = CGRect(x: cosmoPlan.frame.midX - 20, y: cosmoPlan.frame.minY - 20, width: 40, height: 60)

        UIView.animate(withDuration: 1, animations: {
            rocket.frame.origin.y = -120
        }, completion: { _ in

            if let index = self.selfRockets.firstIndex(of: rocket) {
                self.selfRockets.remove(at: index)
            }
            rocket.removeFromSuperview()
        })
    }

    @objc
    func shotIntersects() {
        for rocket in selfRockets {
            for plane in evilCosmoPlanes where plane.layer.presentation()?.frame.intersects(rocket.layer.presentation()?.frame ?? .zero) == true {
                self.counterLabel.text = String(counter)
                let healthEvilPlane = plane.getHealth()

                if healthEvilPlane > 1 {
                    plane.setHealth(healthEvilPlane - 1)
                    UIView.animate(withDuration: 0.4, animations: {
                        plane.alpha = 0.3
                    }, completion: { _ in
                        plane.alpha = 1
                    })
                } else {
                    counter += 1
                    plane.animatiomBang()
                    if let index = evilCosmoPlanes.firstIndex(of: plane) {
                        evilCosmoPlanes.remove(at: index)
                    }
                }
                if let index = self.selfRockets.firstIndex(of: rocket) {
                    self.selfRockets.remove(at: index)
                    rocket.removeFromSuperview()
                }
            }
        }
    }

    @objc
    func shotEvilIntersects() {
        for rocket in evilRockets where ((cosmoPlan.layer.presentation()?.frame.intersects(rocket.layer.presentation()?.frame ?? .zero)) == true) {
            if self.health >= 1 {
                health -= 1
                self.healthLabel.text = String(health)

                if let index = self.evilRockets.firstIndex(of: rocket) {
                    self.evilRockets.remove(at: index)
                }
                rocket.removeFromSuperview()
                UIView.animate(withDuration: 0.4, animations: {
                    self.cosmoPlan.alpha = 0.3
                }, completion: { _ in
                    self.cosmoPlan.alpha = 1
                })
            }
        }
    }

    func setupLvl(lvl: Int) {
        self.evilSpead = lvls[lvl].evilSpead
        self.evilHealth = lvls[lvl].evilHealth
        self.evilBulletGenerate = lvls[lvl].evilBulletGenerate
        self.evilGenerate = lvls[lvl].evilGenerate

        if lvl == 0 {
            end = true
        } else {
            end = false
        }
    }
    func startShotIntesects() {
        interspects = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shotIntersects), userInfo: nil, repeats: true)
    }
    func startRockets() {
        shotingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(shot), userInfo: nil, repeats: true)
    }
    func startEvilShotTimer() {
        evilInterspects = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(shotEvilIntersects), userInfo: nil, repeats: true)
    }
    func startSpawnEvilPlane() {
        let gen = evilGenerate
        spawnEvilPlanes = Timer.scheduledTimer(timeInterval: gen, target: self, selector: #selector(spawnEvilPlane), userInfo: nil, repeats: true)
    }
    func startEvilRockets(_ evilPlane: EvilPlaneView) -> Timer {
        let gen = evilBulletGenerate
        let info = ["evilPlane": evilPlane]
        let shotingTimer = Timer.scheduledTimer(timeInterval: gen, target: self, selector: #selector(evilShot(_:)), userInfo: info, repeats: true)
        evilPlaneShotTimers.append(shotingTimer)
        return shotingTimer
    }
    func stopTimers() {
        shotingTimer?.invalidate()
        shotingTimer = nil
        evilInterspects?.invalidate()
        evilInterspects = nil
        interspects?.invalidate()
        interspects = nil
        spawnEvilPlanes?.invalidate()
        spawnEvilPlanes = nil
        guard let panGestureRecognizer = self.panGestureRecognizer else { return }
        cosmoPlan.removeGestureRecognizer(panGestureRecognizer)
        bangsAnimation()
        removeRocket()
    }

    @objc
    func spawnEvilPlane() {
        var evilPlane: EvilPlaneView
        evilPlane = EvilPlaneView()
        evilPlane.setHealth(evilHealth)
        evilCosmoPlanes.append(evilPlane)
        addSubview(evilPlane)
        let randomX = CGFloat.random(in: 20...(bounds.width - 20))
        evilPlane.frame = CGRect(x: randomX, y: bounds.minY - 40, width: 40, height: 40)

        let timer = startEvilRockets(evilPlane)

        UIView.animate(withDuration: self.evilSpead, delay: .zero, options: [.curveLinear], animations: { [weak self] in
            evilPlane.frame.origin.y = (self?.frame.height ?? 0) + evilPlane.frame.height

        }, completion: { [weak evilPlane] _ in

            guard let evilPlane = evilPlane else { return }

            if let index = self.evilPlaneShotTimers.firstIndex(of: timer) {
                self.evilPlaneShotTimers.remove(at: index)
            }
            timer.invalidate()

            if self.evilCosmoPlanes.contains(evilPlane) {
                if self.health >= 1 {
                    self.health -= 1
                    self.healthLabel.text = String(self.health)
                    self.removeEvilPlane(evilPlane)
                }
            }
        })
    }

    @objc func evilShot(_ timer: Timer) {
        guard let userInfo = timer.userInfo as? [String: AnyObject], let evilPlane = userInfo["evilPlane"] as? EvilPlaneView else { return }
        let rocket = Rocket()
        rocket.setImage("evilRocket")

        let x = (evilPlane.layer.presentation()?.frame.midX ?? .zero) - 20
        let y = evilPlane.bounds.maxY + (evilPlane.layer.presentation()?.frame.maxY ?? .zero)

        rocket.frame = CGRect(x: x, y: y, width: 40, height: 40)
        self.evilRockets.append(rocket)
        self.addSubview(rocket)
        UIView.animate(withDuration: 1, delay: .zero, options: [.curveLinear], animations: {
            rocket.frame.origin.y = self.frame.height + 50
            print("Evil Rocket animated!")

        }, completion: { _ in
            if let index = self.evilRockets.firstIndex(of: rocket) {
                self.evilRockets.remove(at: index)
            }
            rocket.removeFromSuperview()
        })
    }

    func stopGame() {
        endGame()

    }

    func endGame() {
        healthTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(lose), userInfo: nil, repeats: true)

    }

    @objc
    func lose() {
        if counter > 3 && (end != nil) {
            endGame(winlose: "Win")
        } else if health < 1 {
            endGame(winlose: "Lose")
        }
    }
    func endGame(winlose: String) {
        health = 3
        stopTimers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.restartGame()
            self.setupMenu(winlose: winlose)
        }
    }
    func clearView() {
        counterLabel.removeFromSuperview()
        healthLabel.removeFromSuperview()
        cosmoPlan.removeFromSuperview()
        stopTimers()
    }
    func setupMenu(winlose: String) {
        self.controller?.navigationController?.pushViewController(GameMenuViewController(score: counter, winLose: winlose), animated: false)
    }
    func setupLayout() {
        addSubview(counterLabel)
        addSubview(healthLabel)
        addSubview(backButton)
        addSubview(hearthImage)
        NSLayoutConstraint.activate([
            counterLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            healthLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            healthLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),

            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalToConstant: 40),

            hearthImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            hearthImage.leadingAnchor.constraint(equalTo: healthLabel.trailingAnchor),
            hearthImage.heightAnchor.constraint(equalToConstant: 30),
            hearthImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    func cleanEvilRocketTimers() {
        for evilPlaneShotTimer in evilPlaneShotTimers {
            evilPlaneShotTimer.invalidate()
            if let index = self.evilPlaneShotTimers.firstIndex(of: evilPlaneShotTimer) {
                self.evilPlaneShotTimers.remove(at: index)
            }
        }
    }
    func removeEvilPlane(_ evilPlane: EvilPlaneView) {
        if let index = self.evilCosmoPlanes.firstIndex(of: evilPlane) {
            self.evilCosmoPlanes.remove(at: index)
        }
        evilPlane.removeFromSuperview()
    }

    func removeRocket() {
        for rocket in evilRockets {
            if let index = evilRockets.firstIndex(of: rocket) {
                evilRockets.remove(at: index)
            }
            rocket.removeFromSuperview()
        }

        for rocket in selfRockets {
            if let index = selfRockets.firstIndex(of: rocket) {
                selfRockets.remove(at: index)
            }
            rocket.removeFromSuperview()
        }
    }

    func bangsAnimation() {
        for evilCosmoPlane in evilCosmoPlanes {
            evilCosmoPlane.animatiomBang()
            if let index = evilCosmoPlanes.firstIndex(of: evilCosmoPlane) {
                evilCosmoPlanes.remove(at: index)
            }
        }
    }
    func restartGame() {
        counter = 0
        health = 3
        counterLabel.text = String(counter)
        healthLabel.text = String(health)
        cleanEvilRocketTimers()
        removeRocket()
        bangsAnimation()
        startEvilShotTimer()
        startShotIntesects()
        startRockets()
        startSpawnEvilPlane()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
        guard let pan = panGestureRecognizer else { return }
        cosmoPlan.addGestureRecognizer(pan)
    }
}
