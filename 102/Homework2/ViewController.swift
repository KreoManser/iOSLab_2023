//
//  ViewController.swift
//  Homework2
//
//  Created by Faki Doosuur Doris on 14.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Did Appear")
        self.view.backgroundColor = .systemPink
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
    }
    @IBAction func unWind(_ seg: UIStoryboardSegue) {
        
    }
    
}

