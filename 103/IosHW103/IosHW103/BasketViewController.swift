//
//  BasketViewController.swift
//  IosHW103
//
//  Created by Ильмир Шарафутдинов on 08.01.2024.
//

import UIKit

class BasketViewController: UIViewController {
    
    let nameLabelTopAncorConstraints = 100
    let nameLabelLeadingAncorConstraints = 32
    let imageViewTopAncorConstant = 1
    let secondNameLabelTopAncorConstraints = 205
    

    lazy var imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "айфон13 про"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var namelabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Iphone 13 Pro"
        
        return name
    }()
    
    lazy var priceLabel: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.text = "Price: 89 000"
        
        return price
    }()
    
    lazy var secondImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "13"))
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var secondNamelabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Iphone 13"
        
        return name
    }()
    
    lazy var secondPriceLabel: UILabel = {
        let price = UILabel()
        price.translatesAutoresizingMaskIntoConstraints = false
        price.text = "Price: 80 000"
        
        return price
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(myButtonItem))
        navigationItem.rightBarButtonItem = myButton
        
        view.backgroundColor = .white
        setupLayout()
    }
    
    func setupLayout() {
        namelabel.isHidden = true
        imageView.isHidden = true
        priceLabel.isHidden = true
        
        secondNamelabel.isHidden = true
        secondImageView.isHidden = true
        secondPriceLabel.isHidden = true
        
        imageView.contentMode = .scaleAspectFit
        secondImageView.contentMode = .scaleAspectFit
        namelabel.textAlignment = .center
        priceLabel.textAlignment = .center
        secondNamelabel.textAlignment = .center
        secondPriceLabel.textAlignment = .center
        
        view.addSubview(imageView)
        view.addSubview(namelabel)
        view.addSubview(priceLabel)
        
        view.addSubview(secondNamelabel)
        view.addSubview(secondImageView)
        view.addSubview(secondPriceLabel)
        
        
        NSLayoutConstraint.activate([
            namelabel.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(nameLabelTopAncorConstraints)),
            namelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(nameLabelLeadingAncorConstraints)),
            namelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(nameLabelLeadingAncorConstraints)),
            
            imageView.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: CGFloat(imageViewTopAncorConstant)),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(nameLabelTopAncorConstraints)),
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(nameLabelTopAncorConstraints)),
            
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: CGFloat(imageViewTopAncorConstant)),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(nameLabelLeadingAncorConstraints)),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(nameLabelLeadingAncorConstraints)),
            
            secondNamelabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: CGFloat(secondNameLabelTopAncorConstraints)),
            secondNamelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(nameLabelLeadingAncorConstraints)),
            secondNamelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(nameLabelLeadingAncorConstraints)),
            
            secondImageView.topAnchor.constraint(equalTo: secondNamelabel.bottomAnchor, constant: CGFloat(imageViewTopAncorConstant)),
            secondImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondImageView.widthAnchor.constraint(equalToConstant: CGFloat(nameLabelTopAncorConstraints)),
            secondImageView.heightAnchor.constraint(equalToConstant: CGFloat(nameLabelTopAncorConstraints)),
            
            secondPriceLabel.topAnchor.constraint(equalTo: secondImageView.bottomAnchor, constant: CGFloat(imageViewTopAncorConstant)),
            secondPriceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(nameLabelLeadingAncorConstraints)),
            secondPriceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat(nameLabelLeadingAncorConstraints))
        ])
    }
    
    @objc func myButtonItem() {
        if namelabel.isHidden == true &&
            imageView.isHidden == true &&
            priceLabel.isHidden == true &&
            secondNamelabel.isHidden == true &&
            secondImageView.isHidden == true  &&
            secondPriceLabel.isHidden == true {
            
            namelabel.isHidden = false
            imageView.isHidden = false
            priceLabel.isHidden = false
        } else if namelabel.isHidden == false &&
                    imageView.isHidden == false &&
                    priceLabel.isHidden == false &&
                    secondNamelabel.isHidden == true &&
                    secondImageView.isHidden == true  &&
                    secondPriceLabel.isHidden == true {
            
            secondNamelabel.isHidden = false
            secondImageView.isHidden = false
            secondPriceLabel.isHidden = false
        } else if namelabel.isHidden == true &&
                    imageView.isHidden == true &&
                    priceLabel.isHidden == true &&
                    secondNamelabel.isHidden == false &&
                    secondImageView.isHidden == false  &&
                    secondPriceLabel.isHidden == false {
            
            secondNamelabel.isHidden = true
            secondImageView.isHidden = true
            secondPriceLabel.isHidden = true
        } else if namelabel.isHidden == false &&
                    imageView.isHidden == false &&
                    priceLabel.isHidden == false &&
                    secondNamelabel.isHidden == false &&
                    secondImageView.isHidden == false  &&
                    secondPriceLabel.isHidden == false {
            
            namelabel.isHidden = true
            imageView.isHidden = true
            priceLabel.isHidden = true
        }
    }
}
