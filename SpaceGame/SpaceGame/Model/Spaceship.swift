import UIKit

internal class Spaceship {
    internal var position: CGPoint
    internal var health: Int
    internal var imageView: UIImageView!
    internal var bullets = [UIImageView]()
    

    internal init(view: UIView) {
        position = CGPoint(x: 0, y: 0)
        health = 100
        
        imageView = UIImageView(frame: CGRect(x: view.bounds.midX - 50, y: view.bounds.maxY - 130, width: 50, height: 50))
        imageView.image = UIImage(named: "ship.png")
        imageView.contentMode = .scaleAspectFit
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleShip(_:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(panGesture)
        
        view.addSubview(imageView)
    }

    @objc func handleShip(_ gesture: UIPanGestureRecognizer) {
        guard let spaceshipView = gesture.view else { return }
        guard let view = spaceshipView.superview else { return }
        
        let translation = gesture.translation(in: view)
        
        spaceshipView.center.x += translation.x
        
        if spaceshipView.frame.minX < view.bounds.minX {
            spaceshipView.frame.origin.x = view.bounds.minX
        } else if spaceshipView.frame.maxX > view.bounds.maxX {
            spaceshipView.frame.origin.x = view.bounds.maxX - spaceshipView.frame.width
        }
        
        gesture.setTranslation(.zero, in: view)
    }
    
    internal func checkBulletCollision(with invader: Invader) {
        for bullet in bullets {
            let bulletX = bullet.frame.midX
            let invaderMinX = invader.imageView.frame.minX
            let invaderMaxX = invader.imageView.frame.maxX
            
            if bulletX >= invaderMinX && bulletX <= invaderMaxX {
                invader.handleCollision()
            }
        }
    }
    
    internal func startShooting(view: UIView) {
        let bulletImageView = UIImageView(frame: CGRect(x: imageView.frame.midX - 5, y: imageView.frame.minY - 20, width: 10, height: 20))
        bulletImageView.image = UIImage(named: "bullet.png")
        bulletImageView.contentMode = .scaleAspectFit
        view.addSubview(bulletImageView)
        bullets.append(bulletImageView)
        
        UIView.animate(withDuration: 0.5, animations: {
            bulletImageView.frame.origin.y = -20
        }) { _ in
            bulletImageView.removeFromSuperview()
            if let index = self.bullets.firstIndex(of: bulletImageView) {
                self.bullets.remove(at: index)
                self.startShooting(view: view)
            }
        }
    }
}
