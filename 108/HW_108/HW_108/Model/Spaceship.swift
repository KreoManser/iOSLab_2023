import UIKit
class Spaceship: UIView {
    lazy var spaceship: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setUpSpaceship()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpSpaceship() {
        spaceship.image = UIImage(named: "spaceShip")
        addSubview(spaceship)
        spaceship.translatesAutoresizingMaskIntoConstraints = false
        spaceship.contentMode = .scaleAspectFill
        spaceship.clipsToBounds = true
        NSLayoutConstraint.activate([
            spaceship.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            spaceship.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            spaceship.heightAnchor.constraint(equalToConstant: 40),
            spaceship.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
