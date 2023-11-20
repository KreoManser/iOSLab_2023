import UIKit

class Alien: UIView {
    lazy var spaceship: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createShip()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createShip() {
        spaceship.image = UIImage(named: "enemyship")
        addSubview(spaceship)
        spaceship.translatesAutoresizingMaskIntoConstraints = false
        spaceship.contentMode = .scaleAspectFill
        spaceship.clipsToBounds = true
        NSLayoutConstraint.activate([
            spaceship.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            spaceship.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            spaceship.heightAnchor.constraint(equalToConstant: 50),
            spaceship.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
