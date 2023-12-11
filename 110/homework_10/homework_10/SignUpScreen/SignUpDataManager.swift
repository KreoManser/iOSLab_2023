//
//  SignUpDataManager.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 11.12.2023.
//

import Foundation
import UIKit

class SignUpDataManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var selectedImage: UIImage = UIImage()
    var imageSelectedClosure: ((UIImage) -> Void)?

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            self.selectedImage = selectedImage
            imageSelectedClosure?(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
