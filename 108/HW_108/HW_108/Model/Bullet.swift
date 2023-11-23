import UIKit
class Bullet: UIView {
    lazy var bullet: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createBullet()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createBullet() {
        bullet.image = UIImage(named: "bullet")
        addSubview(bullet)
        bullet.translatesAutoresizingMaskIntoConstraints = false
        bullet.contentMode = .scaleAspectFill
        bullet.clipsToBounds = true
        NSLayoutConstraint.activate([
            bullet.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            bullet.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            bullet.heightAnchor.constraint(equalToConstant: 30),
            bullet.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
