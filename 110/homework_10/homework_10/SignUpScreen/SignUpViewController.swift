//
//  SignUpViewController.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 11.12.2023.
//

import UIKit

class SignUpViewController: UIViewController {

    private var signUpView: SignUpView?
    private var signUpDataManager: SignUpDataManager?
    private var coreDataManager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        signUpDataManager = SignUpDataManager()
        setUpSignUpView()
        signUpView?.selectImageTapped = { [weak self] in
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self?.signUpDataManager
            self?.present(imagePicker, animated: true, completion: nil)
            self?.signUpDataManager?.imageSelectedClosure = { [weak self] selectedImage in
                self?.signUpView?.selectImageButton.setImage(selectedImage, for: .normal)
                }
        }
        signUpView?.signUpTapped = { [weak self] login, password, avatarImage in
            self?.coreDataManager.createUser(login: login, password: password, avatarImage: avatarImage)
            self?.navigationController?.popViewController(animated: true)
        }
        setUpNavigationBar()
    }

    private func setUpSignUpView() {
        signUpView = SignUpView(frame: view.bounds)
        view = signUpView
    }

    private func setUpNavigationBar() {
        navigationItem.title = "Регистрация"
    }
}
