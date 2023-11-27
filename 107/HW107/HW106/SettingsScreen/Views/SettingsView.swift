import UIKit

class SettingsView: UIView {
    private lazy var goBackButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.settingsViewController?.dismiss(animated: true)
        }
        button.setTitle("Go to Profile", for: .normal)
        button.backgroundColor = .darkGray
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var appearenceLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark mode"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var appearenceSwitcher: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        return mySwitch
    }()

    private lazy var appearenceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [appearenceLabel, appearenceSwitcher])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
//        stack.spacing = 100
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.settingsViewController?.logOutUser()
        }
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .darkGray
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var settingsViewController: SettingsViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView {
    func setupLayouts() {
        backgroundColor = .white
        addSubview(goBackButton)
        addSubview(appearenceStackView)
        addSubview(logOutButton)

        NSLayoutConstraint.activate([
            goBackButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            goBackButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            goBackButton.widthAnchor.constraint(equalToConstant: 150),
            goBackButton.heightAnchor.constraint(equalToConstant: 40),

            appearenceStackView.topAnchor.constraint(equalTo: goBackButton.bottomAnchor, constant: 10),
            appearenceStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            appearenceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 150),

            logOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            logOutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 40),
            logOutButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
}
