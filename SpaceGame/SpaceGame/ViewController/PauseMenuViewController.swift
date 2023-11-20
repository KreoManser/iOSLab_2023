import UIKit

class PauseMenuViewController: UIViewController {
    private var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupPlayButton()
    }
    
    private func setupBackground() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "space_background.png")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
    }
    
    private func setupPlayButton() {
        playButton = UIButton(type: .custom)
        playButton.setImage(UIImage(named: "play.png"), for: .normal) // Замени на изображение кнопки "Play"
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 100), // Устанавливаем размеры кнопки по необходимости
            playButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func playButtonTapped() {
        startGame()
    }
    
    private func startGame() {
        if let navigationController = self.navigationController {
            let gameVC = GameViewController()
            navigationController.setViewControllers([gameVC], animated: true)
        }
    }
}
