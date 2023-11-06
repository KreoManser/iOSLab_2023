import UIKit

class RegistrationViewController: UIViewController {
    
    
    
    lazy var registrationView = RegistrationView(frame: .zero)
    
    override func loadView() {
        super.loadView()
        
        view = registrationView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationView.controller = self
        navigationItem.title = "Welcome to CatGram"
    }
    
    func actionForButtonEnter(textLogin: String, textPassword: String) {
        if let cat = DataManager.findCat(forLogin: textLogin.lowercased(), password: textPassword.lowercased()) {
            var storyViewController = StoryViewController()
            storyViewController.setData(cat: cat)
            navigationController?.pushViewController(storyViewController, animated: true)
        }
        else if textLogin == "" || textPassword == "" {
            registrationView.showAlert(title: "Внимание", message: "Заполните все поля")
        }
        else{
            registrationView.showAlert(title: "Внимание", message: "Введены некорректные данные")
        }
    }
    
   
    
    
}


