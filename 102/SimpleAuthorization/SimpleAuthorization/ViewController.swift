import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let correctLogin = "Admin"
    let correctPassword = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func pushToProfile(_ sender: UIButton) {
        if (loginTextField.text == correctLogin) && (passwordTextField.text == correctPassword) { performSegue(withIdentifier: "profileID", sender: nil)
        }
    }
    @IBAction func unwindToMainVC (_ sender: UIStoryboardSegue) {
    }
}

