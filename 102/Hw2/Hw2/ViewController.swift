//
//  ViewController.swift
//  Hw2
//
//  Created by surexnx on 14.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textFieldLogin: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldLogin.delegate = self
        textFieldPassword.delegate = self
        
    }
    

    @IBAction func btn(_ sender: Any) {
       // navigationController?.pushViewController(SecondViewController(), animated: true).self
        performSegue(withIdentifier: "cv2", sender: nil)
    }
    
    
    @IBAction func segueButton(_ sender: Any) {
        if(textFieldLogin.text ==  "Admin" && textFieldPassword.text ==  "123"){
            performSegue(withIdentifier: "cv2", sender: nil)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textFieldLogin.text ==  "Admin" else{ return true }
        guard textFieldPassword.text ==  "123" else{ return true }
        performSegue(withIdentifier: "cv2", sender: nil)
        return true
    }
    
    @IBAction func exitView(unwindSegue: UIStoryboardSegue){
       
    }


}

