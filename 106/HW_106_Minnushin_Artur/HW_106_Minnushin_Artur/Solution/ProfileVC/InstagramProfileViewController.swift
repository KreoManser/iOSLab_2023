//
//  ViewController.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 29.10.2023.
//

import UIKit

class InstagramProfileViewController: UIViewController {

    let imageNameList: [String] = ["Photo1", "Photo1", "Photo1",
                                   "Photo1", "Photo1", "Photo1",
                                   "Photo1", "Photo1", "Photo1",
                                   "Photo1", "Photo1", "Photo1",
                                   "Photo1", "Photo1", "Photo1"]
    lazy var avatarImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "avatar"))
        image.layer.cornerRadius = 45
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var countPostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(imageNameList.count)"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var countFollowersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var countFollowingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var postLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Посты"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var followersLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписано"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var followingLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписаны"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Миннушин Артур"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "iOS и С# программист"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    lazy var photoCollectionImageView: UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "photoCollecion"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var underliningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        return label
    }()
    lazy var imageCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(avatarImage)
        view.addSubview(countPostLabel)
        view.addSubview(countFollowersLabel)
        view.addSubview(countFollowingLabel)
        view.addSubview(postLable)
        view.addSubview(followersLable)
        view.addSubview(followingLable)
        view.addSubview(nameLabel)
        view.addSubview(subTitle)
        view.addSubview(photoCollectionImageView)
        view.addSubview(underliningLabel)
        view.addSubview(imageCollection)
        setUpLayout()
    }
    func setUpLayout() {
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarImage.heightAnchor.constraint(equalToConstant: 90),
            avatarImage.widthAnchor.constraint(equalToConstant: 90),
            avatarImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: 110),
            countPostLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            countPostLabel.trailingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: 145),
            countFollowersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                     constant: 25),
            countFollowersLabel.trailingAnchor.constraint(equalTo: countPostLabel.leadingAnchor, constant: 95),
            countFollowingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            countFollowingLabel.trailingAnchor.constraint(equalTo: countFollowersLabel.leadingAnchor, constant: 95),
            postLable.topAnchor.constraint(equalTo: countPostLabel.topAnchor, constant: 35),
            postLable.trailingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: 160),
            followersLable.topAnchor.constraint(equalTo: countFollowersLabel.topAnchor, constant: 35),
            followersLable.trailingAnchor.constraint(equalTo: postLable.leadingAnchor, constant: 135),
            followingLable.topAnchor.constraint(equalTo: countFollowingLabel.topAnchor, constant: 35),
            followingLable.trailingAnchor.constraint(equalTo: followersLable.leadingAnchor, constant: 155),
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 145),
            subTitle.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            subTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 165),
            photoCollectionImageView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20),
            photoCollectionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoCollectionImageView.widthAnchor.constraint(equalToConstant: 30),
            photoCollectionImageView.heightAnchor.constraint(equalToConstant: 30),
            underliningLabel.topAnchor.constraint(equalTo: photoCollectionImageView.bottomAnchor, constant: 10),
            underliningLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            underliningLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            underliningLabel.heightAnchor.constraint(equalToConstant: 1),
            imageCollection.topAnchor.constraint(equalTo: underliningLabel.bottomAnchor, constant: 10),
            imageCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            imageCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            imageCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension InstagramProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNameList.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                for: indexPath) as? CollectionViewCell
                else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: imageNameList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3 - 15,
                      height: view.frame.width/3 - 15)
    }
}
