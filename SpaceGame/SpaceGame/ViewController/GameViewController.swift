import UIKit

internal class GameViewController: UIViewController {
    private var spaceShip: Spaceship?
    private var invaders: [Invader] = []
    private var invaderTimer: Timer?
    private var displayLink: CADisplayLink?
    private var pauseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        spaceShip = Spaceship(view: view)
        spaceShip?.startShooting(view: view)
        spawnInvader()
        startInvaderSpawning()
        setupDisplayLink()
        setupPauseButton()
    }
    
    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .default)
    }
    
    private func setupPauseButton() {
        let buttonSize: CGFloat = 50
        let padding: CGFloat = 20
        let buttonFrame = CGRect(x: view.bounds.width - buttonSize - padding, y: padding + 50, width: buttonSize, height: buttonSize)
        
        pauseButton = UIButton(type: .custom)
        pauseButton.frame = buttonFrame
        pauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
        
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        
        view.addSubview(pauseButton)
    }
    
    @objc private func pauseButtonTapped() {
        if let navigationController = self.navigationController {
            let menuVC = PauseMenuViewController()
            navigationController.setViewControllers([menuVC], animated: true)
        }
    }

    @objc private func update() {
        handleCollisions()
    }

    
    private func setupBackground() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "space_background.png")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
    }
    
    private func handleCollisions() {
        for _ in spaceShip?.bullets ?? [] {
            for invader in invaders {
                spaceShip?.checkBulletCollision(with: invader)
            }
        }
    }
    
    private func startInvaderSpawning() {
        invaderTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.spawnInvader()
        }
        invaderTimer?.fire()
    }
    
    private func spawnInvader() {
        guard let view = self.view else { return }
        
        let invader = Invader(view: view)
        view.addSubview(invader.imageView)
        invaders.append(invader)
        invader.startMoving()
    }
    
    deinit {
        invaderTimer?.invalidate()
    }
}
