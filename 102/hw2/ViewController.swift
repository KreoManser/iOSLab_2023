

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UITextField!
    
    @IBOutlet weak var pizzaImageView: UIImageView!
    
    @IBAction func showProfile(_ sender: Any) {
        let correctLogin = "Admin"
        let correctPassword = "123"
        
        if password.text == correctPassword && login.text == correctLogin {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let ProfileViewController = storyboard.instantiateViewController(identifier: "ProfileViewController")
            ProfileViewController.modalPresentationStyle = .fullScreen

            
            self.present(ProfileViewController,animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func exitToViewController(segue: UIStoryboardSegue) {}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaImageView.layer.cornerRadius = 20
        pizzaImageView.layer.borderWidth = 1.0
    }
    
    
}

