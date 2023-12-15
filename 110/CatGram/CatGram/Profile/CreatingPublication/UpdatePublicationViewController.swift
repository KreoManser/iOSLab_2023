//
//  UpdatePublicationControllerViewController.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 15.12.2023.
//

import UIKit

class UpdatePublicationViewController: UIViewController, CreatingPublicationViewDelegate,
UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private var updateView: CreatingPublicationView?
    private var imagePickerController: UIImagePickerController?
    private var detailpublication: DetailPublication
    private var indexPath: IndexPath

    init(publication: inout DetailPublication, indexPath: IndexPath) {
        self.detailpublication = publication
        self.indexPath = indexPath
        super.init(nibName: .none, bundle: .none)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettings()
        updateView?.photo.image = detailpublication.postImage
        updateView?.fieldDescription.text = detailpublication.caption
    }

    func savePublication() {
        ProfileDataManager.shared.publicationsDictionary[detailpublication.accountName]?[indexPath.row].image = updateView?.photo.image
        ProfileDataManager.shared.publicationsDictionary[detailpublication.accountName]?[indexPath.row].caption =
        updateView?.fieldDescription.text ?? ""
        DetailDataManager.shared.detailPublication[detailpublication.accountName]?[indexPath.row].postImage = updateView?.photo.image
        DetailDataManager.shared.detailPublication[detailpublication.accountName]?[indexPath.row].caption = updateView?.fieldDescription.text ?? ""
        self.navigationController?.popViewController(animated: true)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            updateView?.photo.image = image
            self.detailpublication.postImage = image
            picker.dismiss(animated: true)
        }
    }
    private func showImagePicker(in viewController: UIViewController) {
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
    }

    @objc func imageViewTapped() {
        showImagePicker(in: self)
    }

    private func setUpSettings() {
        navigationItem.title = "Новая публикации"
        updateView = CreatingPublicationView(frame: .zero)
        view = updateView
        updateView?.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        updateView?.photo.addGestureRecognizer(tapGesture)
        updateView?.photo.isUserInteractionEnabled = true
    }
}
