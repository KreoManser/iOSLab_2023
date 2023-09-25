//
//  MySecondViewController.swift
//  Homework2
//
//  Created by Faki Doosuur Doris on 17.09.2023.
//

import UIKit

class MySecondViewController: UIViewController {
    @IBOutlet weak var mySecondImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidAppear()
    }
    
    func viewDidAppear() {
        mySecondImageview.layer.cornerRadius = mySecondImageview.frame.height/2
        mySecondImageview.layer.masksToBounds = true
        self.view.backgroundColor = .systemGray4
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unWindToFirst", sender: self)
    }
}
