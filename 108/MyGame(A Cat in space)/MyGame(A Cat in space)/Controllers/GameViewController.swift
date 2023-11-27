//
//  ViewController.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 16.11.2023.
//

import UIKit
protocol BeganGameDelegate: AnyObject{
    var levelGameDelegate: String {get set}
}
class GameViewController: UIViewController, BeganGameDelegate {
    var levelGameDelegate: String = ""
    var backgroundSpace2: UIImageView!
    var backgroundSpace1: UIImageView!
    var spaceshipLayer: CALayer!
    var initialTouchPoint: CGPoint = CGPoint.zero

    var aliens: [Alien] = []
//    var animatorBullet: UIViewPropertyAnimator?

    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Score:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        aliens = Manager.shared.choiceDifficulties(level: "easy")
        // Создаем два фона
        backgroundSpace1 = createBackground(imageName: "Space")
        backgroundSpace2 = createBackground(imageName: "Space")

        // Добавляем их на главное представление
        view.addSubview(backgroundSpace1)
        view.addSubview(backgroundSpace2)
        view.addSubview(countLabel)


        // Позиционируем второй фон рядом с первым
        backgroundSpace2.frame.origin.y = backgroundSpace1.frame.maxY

        // Запускаем анимацию движения фона
        moveBackground()
        createSpaceship()
        createAliensForEasy()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(animateBullet), userInfo: nil, repeats: true)

        NSLayoutConstraint.activate([
            countLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        setNavigationBar()
        //animateViewUp()
    }

    func createBackground(imageName: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }

    func moveBackground() {
        UIView.animate(withDuration: 10.0, delay: .zero, options: .curveLinear, animations: {
            // Двигаем оба фона вниз
            self.backgroundSpace1.frame.origin.y -= self.view.bounds.height
            self.backgroundSpace2.frame.origin.y -= self.view.bounds.height
        }) { (finished) in
            // После завершения анимации сбрасываем положение фонов, чтобы создать бесконечный эффект
            self.backgroundSpace1.frame.origin.y = 0
            self.backgroundSpace2.frame.origin.y = self.backgroundSpace1.frame.maxY

            // Рекурсивно вызываем анимацию для бесконечности
            self.moveBackground()
        }
    }

    func createSpaceship() {
           spaceshipLayer = CALayer()
           spaceshipLayer.contents = UIImage(named: "SpaceCraft")?.cgImage  // Замените "spaceship" на имя вашего изображения корабля
           spaceshipLayer.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)  // Задайте размеры корабля
           spaceshipLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.height - 100)
           view.layer.addSublayer(spaceshipLayer)
    }

    func createAliensForEasy() {
        aliens = Manager.shared.choiceDifficulties(level: levelGameDelegate)
        for alien in aliens {
            view.layer.addSublayer(alien.layer)
        }

//       for i in 0..<count {  // Создайте 5 пришельцев
//           let alienLayer = CALayer()
//           alienLayer.contents = UIImage(named: "Alien_2")?.cgImage  // Замените "alien" на имя вашего изображения пришельца
//           alienLayer.bounds = CGRect(x: 0, y: 0, width: 50, height: 70)  // Задайте размеры пришельца
//           alienLayer.position = CGPoint(x: CGFloat(50 + i * 70), y: CGFloat(200))
//           view.layer.addSublayer(alienLayer)
//           aliens.append(alienLayer)
//       }
//       Difficulties.shared.easyLevel(aliens: aliens, size: view)
   }
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        switch sender.state {
        case .began:
            initialTouchPoint = spaceshipLayer.position
        case .changed:
            let newX = initialTouchPoint.x + translation.x
            let newY = initialTouchPoint.y + translation.y

            // Ограничиваем новые координаты с учетом safeArea
            let minX = view.safeAreaInsets.left
            let maxX = view.bounds.width - view.safeAreaInsets.right
            let minY = view.safeAreaInsets.top
            let maxY = view.bounds.height - view.safeAreaInsets.bottom - spaceshipLayer.bounds.height

            spaceshipLayer.position.x = max(minX, min(newX, maxX))
            spaceshipLayer.position.y = max(minY, min(newY, maxY))
            for alien in aliens {
                if spaceshipLayer.frame.intersects(alien.layer.frame) {
                    alien.layer.removeFromSuperlayer()
                }
            }
        default:
            break
        }
    }
    var bullets: [UIImageView] = []
    @objc func animateBullet() {
        let bullet = UIImageView(image: UIImage(named: "bullet"))
        bullet.frame = CGRect(x: Int(spaceshipLayer.frame.midX - 10), 
                              y: Int(spaceshipLayer.frame.minY - 10), width: 20, height: 30)
        view.addSubview(bullet)
        UIView.animate(withDuration: 2.0, delay: .zero, options: .curveLinear, animations: {
            self.bullets.append(bullet)
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleBulletHit), userInfo: nil, repeats: true)
            bullet.frame.origin.y = 0


        }) { _ in


            bullet.removeFromSuperview()
        }
    }

    @objc func handleBulletHit() {
        for alien in self.aliens {
            for bullet in bullets {
                if bullet.frame.intersects(alien.layer.frame) {
                    print("Попал")
                    alien.layer.removeFromSuperlayer()
                    self.bullets.removeAll{$0 == bullet}
                } else {
                    print("Не попал")
                    self.bullets.removeAll{$0 == bullet}
                }
            }
        }
    }

    var scoreLabel: UILabel!
    var actionButton: UIBarButtonItem!
    var popupView: UIView!
    func setNavigationBar() {
        scoreLabel = UILabel()
                scoreLabel.text = "Score: 100"
                scoreLabel.textColor = .black

                // Создаем UIBarButtonItem для отображения кнопки на правой стороне навигационной панели
                actionButton = UIBarButtonItem(title: "Action", style: .plain, target: self, action: #selector(showPopup))

                // Устанавливаем UILabel и UIBarButtonItem в навигационной панели
        self.navigationController?.navigationItem.title = ""
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: scoreLabel)
       // self.navigationController?.navigationBar.topItem?.rightBarButtonItem = actionButton
        navigationItem.rightBarButtonItem = actionButton
    }
    @objc func showPopup() {
        // Создаем UIView для отображения всплывающего окна
        popupView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
        popupView.center = view.center
        popupView.backgroundColor = .darkGray
        popupView.layer.cornerRadius = 15

        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.titlePadding = -10

        var actionContinue = UIAction() { _ in
            self.popupView.removeFromSuperview()
        }
        // Добавляем кнопку "Продолжить"
        let continueButton = UIButton(configuration: config, primaryAction: actionContinue)
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.tintColor = .white
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        continueButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        continueButton.layer.borderWidth = 1.0
        continueButton.layer.borderColor = UIColor.white.cgColor
        continueButton.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем кнопку "Выйти"
        var actionExit = UIAction() { _ in
            self.navigationController?.popViewController(animated: false)
        }
        let exitButton = UIButton(configuration: config,primaryAction: actionExit)
        exitButton.setTitle("Выйти", for: .normal)
        exitButton.titleLabel?.font = UIFont.systemFont(ofSize: 100)
        exitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        exitButton.layer.borderWidth = 1.0
        exitButton.layer.borderColor = UIColor.white.cgColor
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        // Добавляем кнопки на всплывающее окно
        popupView.addSubview(exitButton)
        popupView.addSubview(continueButton)

        // Добавляем всплывающее окно на основное представление
        view.addSubview(popupView)

        NSLayoutConstraint.activate([
            continueButton.centerYAnchor.constraint(equalTo: popupView.centerYAnchor,constant: -25),
            continueButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            exitButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20),
            exitButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
        ])

    }
}

