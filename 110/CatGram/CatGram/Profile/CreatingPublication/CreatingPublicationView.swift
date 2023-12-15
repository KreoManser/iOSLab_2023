//
//  CreatingPublicationView.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 13.12.2023.
//

import UIKit

protocol CreatingPublicationViewDelegate: AnyObject {
    func savePublication()
}

class CreatingPublicationView: UIView {

    weak var delegate: CreatingPublicationViewDelegate?

    lazy var addPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите фото из галерии:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var photo: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage.addPhoto
        photo.translatesAutoresizingMaskIntoConstraints = false
        return photo
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавьте описание:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var fieldDescription: UITextField = {
        let field = UITextField()
        field.placeholder = "Описание"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        field.autocorrectionType = .no
        return field
    }()

    lazy var buttonSave: UIButton = {
        let action = UIAction { _ in self.delegate?.savePublication()}
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.addAction(action, for: .touchUpInside)
        button.setTitle("Сохранить", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayout() {
        backgroundColor = .white
        addSubview(addPhotoLabel)
        addSubview(photo)
        addSubview(descriptionLabel)
        addSubview(fieldDescription)
        addSubview(buttonSave)
        NSLayoutConstraint.activate([
            addPhotoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            addPhotoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            photo.centerXAnchor.constraint(equalTo: centerXAnchor),
            photo.topAnchor.constraint(equalTo: addPhotoLabel.bottomAnchor, constant: 10),
            photo.heightAnchor.constraint(equalToConstant: 350),
            photo.widthAnchor.constraint(equalTo: self.widthAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 5),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            fieldDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            fieldDescription.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),

            buttonSave.topAnchor.constraint(equalTo: fieldDescription.bottomAnchor, constant: 10),
            buttonSave.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonSave.heightAnchor.constraint(equalToConstant: 30),
            buttonSave.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
