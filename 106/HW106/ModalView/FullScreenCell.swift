//
//  FullScreenCell.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 30.01.2024.
//

import UIKit

class FullScreenCell: UICollectionViewCell, UIScrollViewDelegate, UITextFieldDelegate {
    
    var presentCompletion: ((UIAlertController) -> Void)?
    var deleteCompletion: (() -> Void)?
    let dataManager = StorageManager.shared
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var discriptionTextField: UITextField!
    var model: Post?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.imageView?.image = UIImage(named: "like")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.setImage(UIImage(named: "selected_like"), for: .selected)
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        discriptionTextField.delegate = self
        discriptionTextField.isEnabled = false
    }
    
    @IBAction func isEditingButton(_ sender: Any) {
        if nameUser.text == UserDefaults.standard.string(forKey: "currentUser") {
            discriptionTextField.isEnabled = true
            discriptionTextField.becomeFirstResponder()
        }
    }
    
    @IBAction func settingsButton(_ sender: Any) {

        let alert = UIAlertController(
            title: "Удалить пост",
            message: "Вы уверены что хотите удалить пост?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            let compl = self.deleteCompletion
            compl?()

        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(cancelAction)
        
        presentCompletion?(alert)
        
    }
    
    @IBAction func likeSelectedAction(_ sender: Any) {
        likeButton.isSelected.toggle()
        guard let key = model?.id else { return }
        UserDefaults.standard.setValue(likeButton.isSelected, forKey: key)
    }
    
    
    func setupCell(model: Post?) {
        guard let model = model else { return }
        self.model = model
        guard let image = model.avatarImageView else { return }
        photoImageView.image = UIImage(data: image)
        discriptionTextField.text = model.inscription
        dateLabel.text = model.date
        nameUser.text = model.login
        likeButton.isSelected = false//UserDefaults.standard.bool(forKey: model.id.uuidString)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.isEnabled = false
        model?.inscription = discriptionTextField.text
        dataManager.saveContext()
        return true
    }
}
