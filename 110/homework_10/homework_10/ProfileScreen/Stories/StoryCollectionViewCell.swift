//
//  StoryCollectionViewCell.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class StoryCollectionViewCell: UICollectionViewCell {

    private lazy var cellImageView: UIImageView = UIImageView()
    private lazy var circledView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpCircledView()
        setUpCellImageView()
    }

    func configure(with story: Story) {
        cellImageView.image = story.storyImage
    }

    private func setUpCircledView() {
        contentView.addSubview(circledView)
        circledView.translatesAutoresizingMaskIntoConstraints = false
        circledView.layer.borderColor = UIColor.gray.cgColor
        circledView.layer.borderWidth = 0.5
        circledView.layer.cornerRadius = 32
        circledView.contentMode = .scaleAspectFill
        circledView.clipsToBounds = true

        NSLayoutConstraint.activate([
            circledView.topAnchor.constraint(equalTo: contentView.topAnchor),
            circledView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            circledView.widthAnchor.constraint(equalToConstant: 65),
            circledView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }

    private func setUpCellImageView() {
        circledView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.layer.cornerRadius = 30
        cellImageView.contentMode = .scaleAspectFill
        cellImageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            cellImageView.centerXAnchor.constraint(equalTo: circledView.centerXAnchor),
            cellImageView.centerYAnchor.constraint(equalTo: circledView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 60),
            cellImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
