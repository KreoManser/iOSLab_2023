//
//  SettingsTableViewCell.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    lazy var cellImageView: UIImageView = UIImageView()
    lazy var nameLabel: UILabel = UILabel()
    lazy var goImageView: UIImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpCellImageView()
        setUpGoImageView()
        setUpNameLabel()
    }

    func configure(with setting: Setting) {
        cellImageView.image = setting.settingImage
        nameLabel.text = setting.settingDescription
    }

    private func setUpCellImageView() {
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true
        cellImageView.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.widthAnchor.constraint(equalToConstant: 30),
            cellImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setUpGoImageView() {
        contentView.addSubview(goImageView)
        goImageView.translatesAutoresizingMaskIntoConstraints = false
        goImageView.contentMode = .scaleAspectFill
        goImageView.clipsToBounds = true
        goImageView.image = UIImage.goIcon

        NSLayoutConstraint.activate([
            goImageView.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor),
            goImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            goImageView.widthAnchor.constraint(equalToConstant: 20),
            goImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setUpNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: goImageView.leadingAnchor, constant: -10)
        ])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            UIView.animate(withDuration: 0.1, animations: {
                self.backgroundColor = UIColor.lightGray
            }, completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.backgroundColor = UIColor.white
                }
            })
        }
    }
}
