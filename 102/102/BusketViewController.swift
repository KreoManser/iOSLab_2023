//
//  BusketViewController.swift
//  102
//
//  Created by Кирилл Щёлоков on 17.09.2023.
//

import UIKit

class BusketViewController: UIViewController {
    
    @IBOutlet weak var firstItemImageView: UIImageView!
    @IBOutlet weak var secondItemImageView: UIImageView!
    @IBOutlet weak var thirdItemImageView: UIImageView!
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var selectButton1: UIButton!
    @IBOutlet weak var selectImageView2: UIImageView!
    
    @IBOutlet weak var selectImageView3: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstItemImageView.image = UIImage(named: "homeImage")
        secondItemImageView.image = UIImage(named: "sunImage")
        thirdItemImageView.image = UIImage(named: "dogImage")
        
        returnButton.layer.cornerRadius = 12
        
        selectedImageView.image = UIImage(named: "selectImage")
        selectImageView2.image = UIImage(named: "selectImage")
        selectImageView3.image = UIImage(named: "selectImage")
        
        submitButton.layer.cornerRadius = 8
    }
    
    @IBAction func selectButtonAction(_ sender: Any) {
        changeSelectImage(imageView:  selectedImageView)
            }
    
    @IBAction func selectButton2Action(_ sender: Any) {
        changeSelectImage(imageView: selectImageView2)
    }
    
    @IBAction func selectButton3Action(_ sender: Any) {
        changeSelectImage(imageView: selectImageView3)
    }
    
    private func changeSelectImage(imageView : UIImageView){
        if imageView.image == UIImage(named: "selectImage") {
            imageView.image = UIImage(named: "unselectedImage")
        } else {
            imageView.image = UIImage(named: "selectImage")
        }

    }
    
}
