//
//  GameView.swift
//  SpaceInvaders
//
//  Created by Ruslan Kozlov on 15.11.2023.
//

import UIKit

class GameView: UIView {

    lazy var backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "photo2"))
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()

    lazy var invaderShips1 = UIImageView(image: UIImage.invaderShips)
    lazy var invaderShips2 = UIImageView(image: UIImage.invaderShips)
    lazy var invaderShips3 = UIImageView(image: UIImage.invaderShips)
    lazy var invaderShips4 = UIImageView(image: UIImage.invaderShips)
    lazy var invaderShips5 = UIImageView(image: UIImage.invaderShips)
    lazy var invaderShips6 = UIImageView(image: UIImage.invaderShips)
    lazy var defendership = UIImageView(image: UIImage.defenderShip)

    var defendershipPanGesture: UIPanGestureRecognizer?
    var invaderBullets: [UIImageView] = []
    var defenderBullet: UIImageView?
    var animator: UIViewPropertyAnimator?
    var displayLink: CADisplayLink?
    var lastUpdateTime: CFTimeInterval = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        addPanGestureToDefendership()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func downwardMovementShip() {
        self.displayLink = CADisplayLink(target: self, selector: #selector(startInvaderShooting))
        self.displayLink?.preferredFramesPerSecond = 1
        self.displayLink?.add(to: .main, forMode: .default)
        let heightScreen = UIScreen.main.bounds.height - 350
        animator = UIViewPropertyAnimator(duration: 15.0, curve: .linear, animations: {
            self.invaderShips1.frame.origin.y += heightScreen
            self.invaderShips2.frame.origin.y += heightScreen
            self.invaderShips3.frame.origin.y += heightScreen
            self.invaderShips4.frame.origin.y += heightScreen
            self.invaderShips5.frame.origin.y += heightScreen
            self.invaderShips6.frame.origin.y += heightScreen
        })
        animator?.addCompletion { position in
            if position == .end {
                self.displayLink?.remove(from: .main, forMode: .default)
                // вызов алерт рестарт
                print("Вы проиграли")
            }
        }
        animator?.startAnimation()
    }

    @objc func startInvaderShooting() {
        let currentTime = displayLink?.timestamp ?? 0.0
        let deltaTime = currentTime - lastUpdateTime
        for invaderShip in [self.invaderShips1, self.invaderShips2, self.invaderShips3, self.invaderShips4, self.invaderShips5, self.invaderShips6] {
            let bullet = UIImageView(image: UIImage.bulletsInvader)
            bullet.frame = CGRect(
                x: (invaderShip.layer.presentation()?.frame.origin.x ?? 0) + invaderShip.frame.width / 2 - 17.5,
                y: invaderShip.layer.presentation()?.frame.origin.y ?? 0, width: 35, height: 35
            )
            addSubview(bullet)
            invaderBullets.append(bullet)

            UIView.animate(withDuration: 5.0, delay: .zero, options: .curveLinear) {
                bullet.frame.origin.y += UIScreen.main.bounds.height
            } completion: { _ in
                bullet.removeFromSuperview()
                if let index = self.invaderBullets.firstIndex(of: bullet) {
                    self.invaderBullets.remove(at: index)
                }
            }
        }
        lastUpdateTime = currentTime
    }

    func DefenderShooting() {
        
    }

    func addPanGestureToDefendership() {
        defendershipPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDefendershipPan(_:)))
        defendership.isUserInteractionEnabled = true
        if let defendershipPanGesture {
            defendership.addGestureRecognizer(defendershipPanGesture)
        }
    }

    @objc func handleDefendershipPan(_ gesture: UIPanGestureRecognizer) {
        guard let defendership = gesture.view else { return }
        let translation = gesture.translation(in: self)
        defendership.center = CGPoint(
            x: defendership.center.x + translation.x,
            y: defendership.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: self)
    }

    func setUpView() {
        let widthScreen = UIScreen.main.bounds.width
        let heightScreen = UIScreen.main.bounds.height
        addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.widthAnchor.constraint(equalToConstant: widthScreen),
            backgroundImage.heightAnchor.constraint(equalToConstant: heightScreen)
        ])
        addSubview(invaderShips1)
        addSubview(invaderShips2)
        addSubview(invaderShips3)
        addSubview(invaderShips4)
        addSubview(invaderShips5)
        addSubview(invaderShips6)
        addSubview(defendership)

        let invaderSize = CGSize(width: 35, height: 35)
        let averX = (widthScreen - invaderSize.width) / 2
        let averY = (heightScreen - invaderSize.height) / 2

        invaderShips1.frame = CGRect(x: averX, y: averY - 300, width: invaderSize.width, height: invaderSize.height)
        invaderShips2.frame = CGRect(x: averX + 60, y: averY - 200, width: invaderSize.width, height: invaderSize.height)
        invaderShips3.frame = CGRect(x: averX - 60, y: averY - 200, width: invaderSize.width, height: invaderSize.height)
        invaderShips4.frame = CGRect(x: averX + 120, y: averY - 300, width: invaderSize.width, height: invaderSize.height)
        invaderShips5.frame = CGRect(x: averX - 120, y: averY - 300, width: invaderSize.width, height: invaderSize.height)
        invaderShips6.frame = CGRect(x: averX, y: averY - 100, width: invaderSize.width, height: invaderSize.height)
        defendership.frame = CGRect(x: averX, y: averY + 300, width: 35, height: 35)
    }
}
