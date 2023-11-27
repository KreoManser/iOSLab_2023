import UIKit

class SettingsView: UIView {
    lazy var exitButton: UIButton = UIButton()
    private var exitButtonActionClosure: (() -> Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func exitButtonTapped() {
        exitButtonActionClosure?()
    }
    func setExitButtonActionClosure(_ closure: @escaping () -> Void) {
        exitButtonActionClosure = closure
    }
    func setUp() {
        setUpExitButton()
    }
    func setUpExitButton() {
        addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.titleLabel?.font = .boldSystemFont(ofSize: 26)
        exitButton.backgroundColor = .red
        exitButton.setTitle("Exit", for: .normal)
        exitButton.layer.cornerRadius = 10
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        exitButton.setTitleColor(.white, for: .normal)
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            exitButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            exitButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            exitButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}
