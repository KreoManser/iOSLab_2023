import UIKit

internal class GameViewController: UIViewController {
    private var spaceShip: Spaceship?
    private var invaders: [Invader] = []
    private var invaderTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        spaceShip = Spaceship(view: view)
        spaceShip?.startShooting(view: view)
        spawnInvader()
        startInvaderSpawning()
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
