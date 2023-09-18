//
//  BasketViewController.swift
//  HW2_main
//
//  Created by Kseniya Skvortsova on 18.09.2023.
//

import UIKit

class BasketViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.layer.cornerRadius=backButton.bounds.height/2
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "vc4", sender: Any?.self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
