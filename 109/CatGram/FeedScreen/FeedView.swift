//
//  FeedView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 04.11.2023.
//

import UIKit

class FeedView: UIView {

    let circularCollectionView = StoryView()
    lazy var logoImage: UIImageView = UIImageView()
    lazy var tableView: UITableView = UITableView()
    lazy var heartButton: UIButton = UIButton()
    lazy var messageButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super .init(frame: frame)
        setUpLogoImage()
        setupHeartButton()
        setupMessageButton()
        setupStory()
        setUpTableView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLogoImage() {
        addSubview(logoImage)
        logoImage.image = UIImage(named: "logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 70),
            logoImage.widthAnchor.constraint(equalToConstant: 150)

        ])
    }
    private func setupStory() {
        addSubview(circularCollectionView)
       // circularCollectionView.isHidden = false
        circularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circularCollectionView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20),
            circularCollectionView.heightAnchor.constraint(equalToConstant: 50),
            circularCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            circularCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    private func setUpTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: circularCollectionView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    private func setupHeartButton() {
        addSubview(heartButton)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .black
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            heartButton.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 200),
            heartButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    private func setupMessageButton() {
        addSubview(messageButton)
        messageButton.setImage(UIImage(systemName: "ellipsis.message"), for: .normal)
        messageButton.tintColor = .black
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            messageButton.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: -50),
            messageButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }

}
