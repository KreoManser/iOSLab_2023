//
//  MycartViewController.swift
//  HomeWork3
//
//  Created by Faki Doosuur Doris on 26.09.2023.
//

import UIKit

class MycartViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let mySecondImageView: UIImageView
        mySecondImageView = UIImageView()
        mySecondImageView.contentMode = .scaleAspectFit
        mySecondImageView.image = UIImage(named: "boot.jpeg")
        mySecondImageView.translatesAutoresizingMaskIntoConstraints = false
        return mySecondImageView
    }()
    
    private lazy var secondLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Boot for fall - $399"
        myLabel.textColor = .black
        myLabel.font = .systemFont(ofSize: 15)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    private lazy var button1: UIButton = {
        var someButton = UIButton.Configuration.borderedTinted()
        someButton.title = "Go To Shop"
        someButton.baseForegroundColor = .black
        
        return UIButton(
            configuration: someButton,
            primaryAction: UIAction { [weak self] _ in
            self?.exitButton()
            })
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "MY CART"
        addVubViews(imageView, secondLabel, button1)
        configureUI()
        

        
    }
    private func exitButton() {
        print("Move to shop")
        let fourthtViewController = ShopTableViewController()
        show(fourthtViewController, sender: self)
    }
}
extension  MycartViewController {
    private func addVubViews(_ subviews: UIView...) {
        subviews.forEach { view.addSubview($0)
        }
    }
    private func configureUI() {
        button1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            
            button1.widthAnchor.constraint(equalToConstant: 250),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 15),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
}
