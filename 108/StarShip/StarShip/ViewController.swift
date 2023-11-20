//
//  ViewController.swift
//  StarShip
//
//  Created by Rustem on 19.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var aliensCount = 0
    
    var aliens = [UIImageView]()
    
    private let spaceship: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "spaceship.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let space: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "space.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(space)
        view.addSubview(spaceship)
        setupUI()
        createAliens()
        createMyBullets()
    }

    var timer = Timer()
    
    private func setupUI(){
        NSLayoutConstraint.activate([
            spaceship.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spaceship.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            spaceship.widthAnchor.constraint(equalToConstant: 75),
            spaceship.heightAnchor.constraint(equalToConstant: 75),
            
            space.heightAnchor.constraint(equalTo: view.heightAnchor),
            space.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        spaceship.isUserInteractionEnabled = true
        spaceship.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture)))
    }
    
    lazy var xPosition = spaceship.centerXAnchor
    
    lazy var yPosition = spaceship.centerYAnchor
    
    var flag = false
    
    func createAliens(){
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height/2
                    
            // Get Random Number for X and Y Under Upper Bound
            let x = Int(arc4random_uniform(UInt32(width)))
            let y = Int(arc4random_uniform(UInt32(height)))
                    
            // Create Image View
            let randomView = UIImageView(frame: CGRect(x: x, y: y, width: 50, height: 50))
            randomView.image = UIImage(named: "alienship1.png")
            
            self.aliens.append(randomView)
                    
            // Add Image as Subview
            
            self.view.addSubview(self.aliens[self.aliensCount])
            
            self.aliensCount += 1
            
            UIView.animate(withDuration: 5.0, delay: .zero, options: [.autoreverse, .repeat], animations: {
                randomView.center.x = 25.0
            })
            if self.aliensCount == 3 {
                self.timer.invalidate()
            }
            })
    }
    
    func createMyBullets(){
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            let bullet: UIImageView = {
                let imageView = UIImageView(frame: CGRect(x: self.spaceship.frame.origin.x+30, y: self.spaceship.frame.origin.y, width: 3, height: 10))
                imageView.backgroundColor = .systemGreen
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
            }()
            self.view.addSubview(bullet)
            UIView.animate(withDuration: 3, delay: .zero, animations: {
                bullet.center.y = 0.0
            },completion: { _ in
                bullet.removeFromSuperview()
            })
            var bulletTimer = Timer()
            var times = 0
            bulletTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
                times += 1
                for alien in self.aliens{
                    if (alien.layer.presentation()?.frame.contains(bullet.layer.presentation()?.frame ?? self.spaceship.frame) ?? false){
                        alien.removeFromSuperview()
                        bullet.removeFromSuperview()
                    }
                }
                if times == 300{
                    bulletTimer.invalidate()
                }
            })
        })
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            flag = true
        }
        else if gesture.state == .changed{
            let translation = gesture.translation(in: self.view)
            UIView.animate(withDuration: 1, delay: .zero, options: [ UIView.AnimationOptions.curveEaseOut], animations:
                {
                self.spaceship.transform.tx = translation.x
                self.spaceship.transform.ty = translation.y
            })
        }
        else if gesture.state == .ended{
            UIView.animate(withDuration: 1, delay: .zero, animations: {
                self.spaceship.transform = .identity
            })
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
}

