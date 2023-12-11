import UIKit
class StartScreenView: UIView {
    lazy var authorization: UIButton = UIButton()
    lazy var registration: UIButton = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpAuthorizationButton()
        setUpRegistrationButton()
    }
    private func setUpAuthorizationButton() {
        addSubview(authorization)
        authorization.translatesAutoresizingMaskIntoConstraints = false
        authorization.setTitle("Авторизоваться", for: .normal)
        authorization.backgroundColor = .systemGray
        authorization.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            authorization.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
//            authorization.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            authorization.heightAnchor.constraint(equalToConstant: 30),
            authorization.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            authorization.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    private func setUpRegistrationButton() {
        addSubview(registration)
        registration.translatesAutoresizingMaskIntoConstraints = false
        registration.setTitle("Зарегистрироваться", for: .normal)
        registration.backgroundColor = .systemGray
        registration.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            registration.centerYAnchor.constraint(equalTo: authorization.bottomAnchor, constant: 40),
//            registration.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            registration.heightAnchor.constraint(equalToConstant: 30),
            registration.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            registration.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
