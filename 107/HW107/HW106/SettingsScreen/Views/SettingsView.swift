import UIKit

class SettingsView: UIView {
    private lazy var appearenceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getSettingsLabel(text: "Dark mode"), getSettingsSwitcher()])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 85
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var languageStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getSettingsLabel(text: "Russian language"), getSettingsSwitcher()])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 85
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var muteStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getSettingsLabel(text: "Mute messages"), getSettingsSwitcher()])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 85
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var numberOfMessagesStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [getSettingsLabel(text: "Number of messages"), getSettingsSwitcher()])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 85
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var settingsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [appearenceStackView, languageStackView, muteStackView, numberOfMessagesStackView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        let action = UIAction { [weak self] _ in
            self?.settingsViewController?.logOutUser()
        }
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .systemGray.withAlphaComponent(0.7)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.addAction(action, for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var settingsViewController: SettingsViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayouts()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView {
    func setupLayouts() {
        backgroundColor = .white
        addSubview(settingsStackView)
        addSubview(logOutButton)

        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            logOutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 40),
            logOutButton.widthAnchor.constraint(equalToConstant: 150),

            settingsStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            settingsStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            settingsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 150)
        ])
    }
}

extension SettingsView {
    func getSettingsLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    func getSettingsSwitcher() -> UISwitch {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        return mySwitch
    }

    func setupGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))

        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)
    }

    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            settingsViewController?.dismiss(animated: true)
        }
    }
}
