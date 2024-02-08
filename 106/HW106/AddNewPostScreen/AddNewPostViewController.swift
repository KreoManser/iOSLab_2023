//
//  AddNewPostViewController.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 07.02.2024.
//

import UIKit

class AddNewPostViewController: UIViewController {

    @IBOutlet weak var addNewPostImage: UIImageView!
    
    @IBOutlet weak var discriptionTextField: UITextField!
    
    lazy var dataManager = StorageManager.shared
    var isImageAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addNewPostImageAction))

        addNewPostImage.isUserInteractionEnabled = true
        addNewPostImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNewPostImage.image = UIImage(named: "addImage")
        discriptionTextField.text = ""
    }
    
    @objc
    func addNewPostImageAction() {
        let vc = UIImagePickerController ()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func createButtonAction(_ sender: Any) {
        if isImageAdded == false {
            return
        }
        let post = Post(context: dataManager.viewContext)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        post.id = UUID().uuidString
        post.date = formatter.string(from: .now)
        post.avatarImageView = addNewPostImage.image?.pngData()
        post.inscription = discriptionTextField.text
        post.login = UserDefaults.standard.string(forKey: "currentUser")
        let users = dataManager.obtainSavedData()
        for user in users {
            if user.name == post.login {
                user.addToPosts(post)
            }
        }
        dataManager.saveContext()
        tabBarController?.selectedIndex = 4
    }
    
}

extension AddNewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey (rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            addNewPostImage.image = image
            isImageAdded = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
