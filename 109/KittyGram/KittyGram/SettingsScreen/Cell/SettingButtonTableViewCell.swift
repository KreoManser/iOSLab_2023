//
//  SettingButtonTableViewCell.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 01.12.2023.
//

import UIKit

class SettingButtonTableViewCell: UITableViewCell {
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = .white
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.customBlack
        addSubviews(subviews: buttonImageView, titleLabel)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingButtonTableViewCell {
    func configureCell(with button: SettingButton) {
        buttonImageView.image = UIImage(systemName: button.imageName)
        titleLabel.text = button.title
    }
}

extension SettingButtonTableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    private func addSubviews(subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }

    private func configureUI() {
        NSLayoutConstraint.activate([
            buttonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            buttonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            buttonImageView.widthAnchor.constraint(equalToConstant: 20),
            buttonImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.leadingAnchor.constraint(equalTo: buttonImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)])
    }
}
