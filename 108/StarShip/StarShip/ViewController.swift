//
//  ViewController.swift
//  StarShip
//
//  Created by Rustem on 19.11.2023.
//

import UIKit

class ViewController: UIViewController {

    var aliensCount = 0

    var score = 0

    var aliens: [UIImageView] = []

    private let spaceship: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "spaceship.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var countLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "0"
        label.textColor = .white
        return label
    }()

    private let space: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "space.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let scoreLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Score"
        label.font = UIFont.systemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        view.addSubview(space)
        view.addSubview(spaceship)
        createAliens()
        createMyBullets()
        view.addSubview(scoreLabel)
        view.addSubview(countLabel)
        setupUI()
    }

    var timer = Timer()

    private func setupUI() {
        NSLayoutConstraint.activate([
            spaceship.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spaceship.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            spaceship.widthAnchor.constraint(equalToConstant: 75),
            spaceship.heightAnchor.constraint(equalToConstant: 75),

            space.heightAnchor.constraint(equalTo: view.heightAnchor),
            space.widthAnchor.constraint(equalTo: view.widthAnchor),

            scoreLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            countLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 3),
            countLabel.centerXAnchor.constraint(equalTo: scoreLabel.centerXAnchor)
        ])

        spaceship.isUserInteractionEnabled = true
        spaceship.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture)))
    }

    lazy var xPosition = spaceship.centerXAnchor

    var alienBoss: UIImageView = {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 2

        var imageView = UIImageView(frame: CGRect(x: width / 2, y: 100, width: 100, height: 150))
        imageView.image = UIImage(named: "ship7")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var yPosition = spaceship.centerYAnchor

    var bossHP = 5

    var flag = false

    func createAliens() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height / 2

            // Get Random Number for X and Y Under Upper Bound
            let x = Int.random(in: 0...Int(width))
            let y = Int.random(in: 0...Int(height))

            // Create Image View
            let randomView = UIImageView(frame: CGRect(x: x, y: y, width: 50, height: 50))
            randomView.image = UIImage(named: "alienship1.png")

            self.aliens.append(randomView)

            self.createAlienBullets()

            // Add Image as Subview
                self.view.addSubview(self.aliens[self.aliensCount])

            self.aliensCount += 1

            UIView.animate(withDuration: 5.0, delay: .zero, options: [.autoreverse, .repeat], animations: {
                randomView.center.x = 25.0
            })
            if self.aliensCount == 3 {
                self.timer.invalidate()
            }
        })
    }

    func createAlienBullets() {
        guard let alien = aliens.last else { return }
        var alienBulletTimer = Timer()
        alienBulletTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { [weak alienBulletTimer] _ in
            let bullet: UIImageView = {
                let xPos = alien.layer.presentation()?.frame.origin.x ?? alien.frame.origin.x
                let imageView = UIImageView(frame: CGRect(x: xPos + 20, y: alien.frame.origin.y + alien.frame.height, width: 3, height: 10))
                    imageView.backgroundColor = .systemRed
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    return imageView
                }()
            if alien.image == UIImage(named: "explosion") {
                alienBulletTimer?.invalidate()
                }
                self.view.addSubview(bullet)
                UIView.animate(withDuration: 3, delay: .zero, animations: {
                    bullet.center.y = 800.0
                }, completion: { _ in
                    bullet.removeFromSuperview()
                })
                var bulletTimer = Timer()
                var times = 0
                bulletTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak bulletTimer] _ in
                    times += 1
                    if self.spaceship.layer.presentation()?.frame.contains(bullet.layer.presentation()?.frame ?? alien.frame) ?? false {
                        self.navigationController?.popToRootViewController(animated: true)
                        }
                    if times == 300 {
                        bulletTimer?.invalidate()
                    }
                })
            })
    }

    func createAlienBoss() {

        view.addSubview(alienBoss)
        NSLayoutConstraint.activate([
            alienBoss.widthAnchor.constraint(equalToConstant: 100),
            alienBoss.heightAnchor.constraint(equalToConstant: 150),
            alienBoss.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            alienBoss.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        self.flag = true

        var alienBulletTimer = Timer()
        alienBulletTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak alienBulletTimer] _ in
            let bullet: UIImageView = {
                let xPos = self.alienBoss.layer.presentation()?.frame.origin.x ?? self.alienBoss.frame.origin.x
                let yPos = self.alienBoss.frame.origin.y + self.alienBoss.frame.height
                let imageView = UIImageView(frame: CGRect(x: xPos + 45, y: yPos, width: 5, height: 10))
                    imageView.backgroundColor = .systemYellow
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    return imageView
                }()
            if self.alienBoss.image == UIImage(named: "explosion") {
                alienBulletTimer?.invalidate()
                }
                self.view.addSubview(bullet)
                UIView.animate(withDuration: 3, delay: .zero, animations: {
                    bullet.center.y = 800.0
                }, completion: { _ in
                    bullet.removeFromSuperview()
                })
                var bulletTimer = Timer()
                var times = 0
                bulletTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak bulletTimer] _ in
                    times += 1
                    if self.spaceship.layer.presentation()?.frame.contains(bullet.layer.presentation()?.frame ?? self.alienBoss.frame) ?? false {
                        self.navigationController?.popToRootViewController(animated: true)
                        }
                    if times == 300 {
                        bulletTimer?.invalidate()
                    }
                })
            })
    }

    func createMyBullets() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            let bullet: UIImageView = {
                let yPos = self.spaceship.frame.origin.y
                let imageView = UIImageView(frame: CGRect(x: self.spaceship.frame.origin.x + 30, y: yPos, width: 3, height: 10))
                imageView.backgroundColor = .systemGreen
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            self.view.addSubview(bullet)
            UIView.animate(withDuration: 3, delay: .zero, animations: {
                bullet.center.y = 0.0
            }, completion: { _ in
                bullet.removeFromSuperview()
            })
            var bulletTimer = Timer()
            var times = 0

            if self.score == 3 {
                self.createAlienBoss()
                self.score += 1
            }

            bulletTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {[weak bulletTimer] _ in
                times += 1

                if self.flag == false {
                    for alien in self.aliens {
                        if alien.layer.presentation()?.frame.contains(bullet.layer.presentation()?.frame ?? self.spaceship.frame) ?? false {
                            if alien.image != UIImage(named: "explosion") {
                                self.score += 1
                                self.countLabel.text = "\(self.score)"
                                alien.image = UIImage(named: "explosion")
                                let transform = CGAffineTransform(scaleX: 2, y: 2)
                                alien.frame.origin.x = alien.layer.presentation()?.frame.origin.x ?? 0
                                alien.layer.removeAllAnimations()
                                UIView.animate(withDuration: 4, animations: {
                                    alien.transform = transform
                                }, completion: { _ in
                                    alien.frame.origin.x = -100
                                    alien.removeFromSuperview()
                                })
                            }
                            bullet.removeFromSuperview()
                        }
                    }
                } else {
                    if self.alienBoss.layer.presentation()?.frame.contains(bullet.layer.presentation()?.frame ?? self.spaceship.frame) ?? false {
                        if self.bossHP == 0 {
                            self.countLabel.text = "WIN!"
                            bullet.removeFromSuperview()
                            self.alienBoss.center.x = 1000
                            self.alienBoss.removeFromSuperview()
                            self.delay(7) {
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        } else {
                            self.bossHP -= 1
                            bullet.center.x = 10000
                            bullet.removeFromSuperview()
                            print(self.bossHP)
                        }
                    }
                }
                if times == 300 {
                    bulletTimer?.invalidate()
                }
            })
        })
    }

    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
        } else if gesture.state == .changed {
            let translation = gesture.translation(in: self.view)
            UIView.animate(withDuration: 1, delay: .zero, options: [ UIView.AnimationOptions.curveEaseOut], animations: {
                self.spaceship.transform.tx = translation.x
                self.spaceship.transform.ty = translation.y
            })
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 1, delay: .zero, animations: {
                self.spaceship.transform = .identity
            })
        }
    }

    func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

}

