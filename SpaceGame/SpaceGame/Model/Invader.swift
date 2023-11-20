import UIKit

internal class Invader {
    private var position: CGPoint
    internal var imageView: UIImageView!
    private var invaderMovementTimer: Timer?
    internal var health: Int
    
    init(view: UIView) {
        position = CGPoint(x: CGFloat.random(in: 50...view.bounds.width - 50), y: -50)
        health = 60
        imageView = UIImageView(frame: CGRect(x: position.x, y: position.y, width: 40, height: 40))
        imageView.image = UIImage(named: "invader.png")
        imageView.contentMode = .scaleAspectFit
    }
    
    internal func startMoving() {
        invaderMovementTimer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.position.y += 1
            self.imageView.frame.origin.y = self.position.y
            
            if self.position.y > UIScreen.main.bounds.height {
                self.invaderMovementTimer?.invalidate()
                self.imageView.removeFromSuperview()
            }
        }
    }
    
    internal func handleCollision() {
        health -= 20 // Уменьшаем здоровье пришельца после столкновения с пулей
        
        if health <= 0 {
            invaderMovementTimer?.invalidate()
            imageView.removeFromSuperview()
        }
    }
    
    deinit {
        invaderMovementTimer?.invalidate()
    }
}

