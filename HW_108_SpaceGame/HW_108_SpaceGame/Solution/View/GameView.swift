//
//  GameView.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 20.11.2023.
//

import UIKit

class GameView: UIView {
    var gameCredits: Int = 0
    var player = Player.sigelton
    var gameVC: GameViewController?
    var isLeft = false
    var isRight = false
    var numberOfWave = 1
    var countAliens = 0
    var aliensTimer = Timer()
    var aliensBossTimer = Timer()
    var alienGenerateBullet = Timer()
    var alienCheckHitBullet = Timer()
    var alienBossCheckHitBullet = Timer()
    var spaceShipAlienHitBullet = Timer()
    var enemyList: [UIImageView] = []
    var bossHp = 5
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Space"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var creditsLbael: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Credits: \(gameCredits)"
        label.textColor = .systemMint
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var hpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemMint
        label.text = "Hp: \(player.heatPoint)"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var waveLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemMint
        label.sizeToFit()
        label.text = "Wave: \(numberOfWave)"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var playerImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        addSubview(creditsLbael)
        addSubview(playerImageView)
        addSubview(hpLabel)
        addSubview(waveLabel)
        setupLayout()
        setupSwipe()
        setupTap()
        setupWave()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GameView {
    func generateAliens(alienLvlList: [LevelEnemy]) {
        var counter = -1
        enemyList = []
        aliensTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {_ in
            counter += 1
            let alienlvl = alienLvlList[counter]
            let screenWidth = self.frame.width
            let screenHeight = self.frame.height
            let posX = Int(screenWidth / 2 - 25)
            let posY = Int.random(in: 50...Int(screenHeight / 4))
            var enemy = UIImageView(frame: CGRect(x: posX, y: posY, width: 50, height: 40))
            switch alienlvl {
            case .level1:
                enemy.image = UIImage(named: "Enemy1")
            case .level2:
                enemy.image = UIImage(named: "Enemy2")
            case .level3:
                enemy.image = UIImage(named: "Enemy3")
            case .level4:
                enemy.image = UIImage(named: "Enemy4")
            case .boss:
                enemy = UIImageView(frame: CGRect(x: 0, y: posY, width: 150, height: 120))
                enemy.image = UIImage(named: "BossEnemy")
            }
            self.enemyList.append(enemy)
            self.alienFireFunc()
            self.addSubview(self.enemyList[self.countAliens])
            self.countAliens += 1
            let translation = Int.random(in: 0...1)
            if !(enemy.image == UIImage(named: "BossEnemy")) {
                UIView.animate(withDuration: 2.0, delay: .zero, options: [.autoreverse, .repeat], animations: {
                    if translation == 0 {
                        enemy.frame.origin.x += screenWidth / 2 - 20
                    } else if translation == 1 {
                        enemy.frame.origin.x -= screenWidth / 2 - 20
                    }
                })
            } else {
                UIView.animate(withDuration: 2.0, delay: .zero, options: [.autoreverse, .repeat], animations: {
                    enemy.frame.origin.x = screenWidth - 150
                })
            }
            if self.countAliens == alienLvlList.count {
                self.aliensTimer.invalidate()
            }
        })
    }
    func alienFireFunc() {
        guard let enemy = enemyList.last else { return }
        var timeinterval: Double = 0
        if enemy.image == UIImage(named: "BossEnemy") {
            timeinterval = 0.2
        } else { timeinterval = 2.0 }
        alienGenerateBullet = Timer.scheduledTimer(withTimeInterval: timeinterval, repeats: true, block: {_ in
            let xPos = enemy.layer.presentation()?.frame.origin.x ?? enemy.frame.origin.x
            let yPos = enemy.frame.origin.y + 50
            let alienBullet: UIImageView = {
                let imageView = UIImageView(frame: CGRect(x: xPos + 20, y: yPos, width: 3, height: 20))
                imageView.backgroundColor = .red
                self.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            self.addSubview(alienBullet)
            let animatorBullet = UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: {
                alienBullet.center.y = self.frame.height
            })
            animatorBullet.addCompletion({_ in alienBullet.removeFromSuperview() })
            animatorBullet.startAnimation()
            var times = 0
            self.alienCheckHitBullet =
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
                times += 1
                if self.playerImageView.layer.presentation()?
                    .frame.contains(alienBullet.layer.presentation()?
                        .frame ?? enemy.frame) ?? false {
                    switch enemy.image {
                    case UIImage(named: "Enemy1"):
                        self.player.heatPoint -= 1
                    case UIImage(named: "Enemy2"):
                        self.player.heatPoint -= 2
                    case UIImage(named: "Enemy3"):
                        self.player.heatPoint -= 3
                    case UIImage(named: "Enemy4"):
                        self.player.heatPoint -= 4
                    case UIImage(named: "BossEnemy"):
                        self.player.heatPoint -= 5
                    default:
                        self.gameCredits += 0
                    }
                    alienBullet.removeFromSuperview()
                    self.checkHp()
                }
                if times == 200 { self.alienCheckHitBullet.invalidate() }
            })
        })
    }
    func checkHp() {
        if self.player.heatPoint <= 0 {
            player.setupPlayer()
            player.totalCredit += self.gameCredits
            gameVC?.dismisVC(text: "Ты проиграл!")
        } else {
            self.hpLabel.text = "Hp: \(self.player.heatPoint)"
        }
    }
}

extension GameView {
    func setupTap() {
        let tapForFire = UITapGestureRecognizer(target: self, action:
                #selector(self.playerShootingFunc))
        addGestureRecognizer(tapForFire)
    }
    @objc func playerShootingFunc() {
        let playerBullet: UIImageView = {
            let xPos = self.playerImageView.frame.origin.x + 40
            let yPos = self.playerImageView.frame.origin.y
            let view = UIImageView(frame: CGRect(x: xPos, y: yPos, width: 3, height: 20))
            view.backgroundColor = .green
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        self.addSubview(playerBullet)
        let animatorBullet = UIViewPropertyAnimator(duration: 2.0,
                curve: .linear, animations: {
            let tranlslation = CGAffineTransform(translationX: 0, y: -self.frame.height)
            playerBullet.transform = tranlslation })
        animatorBullet.addCompletion({_ in playerBullet.removeFromSuperview()})
        animatorBullet.startAnimation()
        spaceShipAlienHitBullet = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {_ in
            for enemy in self.enemyList where enemy.layer.presentation()?.frame
                .contains(playerBullet.layer.presentation()?
                    .frame ?? (self.playerImageView.frame)) ?? false {
                self.countAliens -= 1
                switch enemy.image {
                case UIImage(named: "Enemy1"):
                    self.gameCredits += 10
                case UIImage(named: "Enemy2"):
                    self.gameCredits += 20
                case UIImage(named: "Enemy3"):
                    self.gameCredits += 30
                case UIImage(named: "Enemy4"):
                    self.gameCredits += 40
                case UIImage(named: "BossEnemy"):
                    self.gameCredits += 100
                default:
                    self.gameCredits += 0
                }
                self.creditsLbael.text = String(describing: "Cr: \(self.gameCredits)")
                playerBullet.removeFromSuperview()
                enemy.frame.origin.x = enemy.layer.presentation()?.frame.origin.x ?? 0
                enemy.layer.removeAllAnimations()
                enemy.frame.origin.x -= 1000
                enemy.removeFromSuperview()
                if self.countAliens == 0 {
                    self.numberOfWave += 1
                    self.waveLabel.text = String(describing: "Wv: \(self.numberOfWave)")
                    self.setupWave()
                }
            }
        })
    }
}

extension GameView {
    func setupSwipe() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.moveShipRight))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.moveShipLeft))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)
    }
    @objc func moveShipRight(sender: UISwipeGestureRecognizer) {
        if !isLeft {
            UIView.animate(withDuration: 0.7) {
                let transaltion = CGAffineTransform(translationX: self.frame.width/2 - 40, y: 0)
                self.playerImageView.transform = transaltion
                self.isRight = true
            }
        } else {
            UIView.animate(withDuration: 0.7) {
                self.playerImageView.transform = .identity
                self.isLeft = false
            }
        }
    }
    @objc func moveShipLeft(sender: UISwipeGestureRecognizer) {
        if !isRight {
            UIView.animate(withDuration: 0.7) {
                let transaltion = CGAffineTransform(translationX: -self.frame.width/2 + 40, y: 0)
                self.playerImageView.transform = transaltion
                self.isLeft = true
            }
        } else {
            UIView.animate(withDuration: 0.7) {
                self.playerImageView.transform = .identity
                self.isRight = false
            }
        }
    }
}

extension GameView {
    func setupWave() {
        switch numberOfWave {
        case 1:
            let list: [LevelEnemy] = [.level1, .level1, .level1, .level2]
            generateAliens(alienLvlList: list)
        case 2:
            let list: [LevelEnemy] = [.level1, .level2, .level2, .level3]
            generateAliens(alienLvlList: list)
        case 3:
            let list: [LevelEnemy] = [.level2, .level3, .level3, .level4]
            generateAliens(alienLvlList: list)
        case 4:
            let list: [LevelEnemy] = [.boss]
            generateAliens(alienLvlList: list)
        case 5:
            gameVC?.dismisVC(text: "Ты победил!")
        default:
            generateAliens(alienLvlList: [])
        }
    }
    func setupPlayer(player: Player) {
        self.player = player
        setupPlayerShip()
    }
    func setupPlayerShip() {
        playerImageView.image = player.shipImageView.image
        NSLayoutConstraint.activate([
            playerImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            playerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playerImageView.widthAnchor.constraint(equalToConstant: 80),
            playerImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(
                equalTo: topAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: 10),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: 0),
            creditsLbael.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            creditsLbael.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            hpLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            hpLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            waveLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            waveLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
}
