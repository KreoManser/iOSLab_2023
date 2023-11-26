import UIKit

class GameLauncherViewController: UIViewController {

    lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Space Combat"
        label.font = .boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        return label
    }()

    lazy var startGameLabel: UILabel = {
        let label = UILabel()
        label.text = "Select difficulty:"
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    lazy var easyLevelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Easy", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        button.bounds.size = CGSize(width: 80, height: 40)
        button.layer.cornerRadius = button.frame.height / 2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        view.addSubview(gameNameLabel)
        view.addSubview(startGameLabel)
        view.addSubview(easyLevelButton)

        easyLevelButton.addTarget(self, action: #selector(startEasyGameTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            gameNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            gameNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 150),
            gameNameLabel.widthAnchor.constraint(equalToConstant: 300),

            startGameLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 40),
            startGameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startGameLabel.heightAnchor.constraint(equalToConstant: 80),
            startGameLabel.widthAnchor.constraint(equalToConstant: 200),

            easyLevelButton.topAnchor.constraint(equalTo: startGameLabel.bottomAnchor, constant: 5),
            easyLevelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            easyLevelButton.heightAnchor.constraint(equalToConstant: 40),
            easyLevelButton.widthAnchor.constraint(equalToConstant: 80)
        ])

    }

    @objc func startEasyGameTapped() {
        let easyVC = EasyGameViewController()
        self.navigationController?.pushViewController(easyVC, animated: true)
    }

}
