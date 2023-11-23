import UIKit
class Alien: UIView {
    lazy var spaceship: UIImageView = UIImageView()
    let currentAlien: String
    let height: CGFloat
    let width: CGFloat
    var health: Int
    var bulletSpeed: CGFloat
    init(currentAlien: String, height: CGFloat, width: CGFloat, health: Int, bulletSpeed: CGFloat) {
        self.currentAlien = currentAlien
        self.height = height
        self.width = width
        self.health = health
        self.bulletSpeed = bulletSpeed
        super.init(frame: .zero)
        backgroundColor = .clear
        createShip()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createShip() {
        spaceship.image = UIImage(named: currentAlien)
        addSubview(spaceship)
        spaceship.translatesAutoresizingMaskIntoConstraints = false
        spaceship.contentMode = .scaleAspectFill
        spaceship.clipsToBounds = true
        NSLayoutConstraint.activate([
            spaceship.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            spaceship.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            spaceship.heightAnchor.constraint(equalToConstant: height),
            spaceship.widthAnchor.constraint(equalToConstant: width)
        ])
    }
}
