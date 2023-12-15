//
//  CreatingPublicationController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 13.12.2023.
//

import UIKit

protocol CreatingPublicationControllerDelegate: AnyObject {
    func reloadData()
}

class CreatingPublicationController: UIViewController, UIImagePickerControllerDelegate,
CreatingPublicationViewDelegate,
UINavigationControllerDelegate {
    private var creatingPublicationsView: CreatingPublicationView?
    private var imagePickerController: UIImagePickerController?
    weak var delegate: CreatingPublicationControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettings()
    }

    @objc func imageViewTapped() {
        showImagePicker(in: self)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true)
            creatingPublicationsView?.photo.image = image
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    private func showImagePicker(in viewController: UIViewController) {
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
    }

    func savePublication() {
        guard let userName = UserDefaults.standard.string(forKey: "user"),
            let avatarData = UserDefaults.standard.data(forKey: "avatarData"),
            let photo = creatingPublicationsView?.photo.image,
            let description = creatingPublicationsView?.fieldDescription.text
        else { return }
        let id = UUID()
        if ProfileDataManager.shared.publicationsDictionary[userName] == nil {
            ProfileDataManager.shared.publicationsDictionary[userName] = []
        }
        ProfileDataManager.shared.publicationsDictionary[userName]?.append(
            ProfilePublication(
                id: id,
                image: photo,
                caption: description,
                date: "1 секунду назад",
                isLiked: false,
                userProfile: (userName: userName, avatar: UIImage(data: avatarData))
            )
        )
        if DetailDataManager.shared.detailPublication[userName] == nil {
            DetailDataManager.shared.detailPublication[userName] = []
        }
        DetailDataManager.shared.detailPublication[userName]?.append(
            DetailPublication(
                id: id,
                avatarImage: UIImage(data: avatarData),
                accountName: userName,
                postImage: photo,
                caption: description,
                date: "1 секунду назад",
                isLiked: false)
        )
        self.delegate?.reloadData()
        self.navigationController?.popViewController(animated: true)
    }

    private func setUpSettings() {
        navigationItem.title = "Новая публикации"
        creatingPublicationsView = CreatingPublicationView(frame: .zero)
        view = creatingPublicationsView
        creatingPublicationsView?.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        creatingPublicationsView?.photo.addGestureRecognizer(tapGesture)
        creatingPublicationsView?.photo.isUserInteractionEnabled = true
    }
}

