//
//  ViewController.swift
//  HomeWork_2
//
//  Created by Нияз Ризванов on 14.09.2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonPress: UIButton!
    @IBOutlet weak var loginTextField: UITextField!
    
    /// Жизненный цикл экрана ( методы loadView и  viewDidLoad срабатывают только один раз, остальные сколько угодно)
    // Самый первый - инициализация
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    // Вызывается перед загрузкой view - тут экран ещё не видно
    override func loadView() {
        super.loadView() // вызываем это тк нет логики
    }
    // Вызывается когда view уже загрузилась - тут экран ещё не видно
    override func viewDidLoad() {
        super.viewDidLoad()
        messageText.isHidden = true
        loginTextField.delegate = self
        passwordTextField.delegate = self
        buttonPress.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    // Вызывается когда view вот вот появиться
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // вызываем это тк нет логики
        // тут можно прописать действия которые будут исполняться при каждом заходе на экран
    }
    // Промежуточные методы
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    //
    // Вызывается когда экран появился
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // тут можно прописать действия которые будут исполняться когда пользователь увидел экран
    }
    // Вызыватся когда переходим на другой экран или сворачиваем экран
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    // Вызывается когда объект удален из памяти
    deinit {
        
    }
    ///
    
    @objc func loginButtonTapped() {
        if loginTextField.text == "Admin", passwordTextField.text == "123" {
            performSegue(withIdentifier: "switchingAccount", sender: self)
        }
        else if !loginTextField.hasText || !passwordTextField.hasText {
            showMessage(message: "Заполните все поля")
        }
        else{
            showMessage(message: "Введены некорректные данные")
        }
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func showMessage(message: String){
        messageText.alpha = 1
        messageText.isHidden = false
        messageText.text = message
        UIView.animate(withDuration: 2.0, animations: { () -> Void in self.messageText.alpha = 0
        })
    }
    
// Выходящее окно
//    func showAlert(title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
    
    @IBAction func chanel(segue: UIStoryboardSegue){}
}

