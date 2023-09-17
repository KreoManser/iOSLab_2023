import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginTextArea: UITextField!
    @IBOutlet weak var passwordTextArea: UITextField!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.layer.cornerRadius = mainImage.frame.size.width / 20
    }
    
    @IBAction func actionButton(_ sender: Any) {
        
        let enteredLogin = loginTextArea.text ?? ""
        let enteredPassword = passwordTextArea.text ?? ""
        
        if isValidLogin(enteredLogin, password: enteredPassword) {
            performSegue(withIdentifier: "ProfileSegue", sender: self)
        } 
        else
        {
            showAlert(title: "Ошибка", message: "Неверный логин или пароль")
        }
    }
    
    func isValidLogin(_ login: String, password: String) -> Bool {
        
        return login == "Admin" && password == "123"
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
