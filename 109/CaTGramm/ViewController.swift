//
//  ViewController.swift
//  CaTGramm
//
//  Created by Rustem on 28.10.2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    init() {
        super.init(nibName: nil, bundle: nil)

        DataManager.OurDataManager.currentUser = UserManager.shared.syncGetUserByName(username: UserDefaults.standard.string(forKey: "current_user") ?? "UsualCat")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCell.identifier, for: indexPath) as? PictureCell else {
            fatalError("Failed to dequeue CalcButtonCell in CalcView")
        }
        let picture = self.datasource[indexPath.row].picture

        cell.configureCell(picture)
        return cell
    }

    var datasource = DataManager.OurDataManager.syncGetCurrentUserPosts()

    lazy var profilePic: UIImageView = {
        var picture = UIImageView(image: UIImage(named: DataManager.OurDataManager.currentUser.avatar ))
        picture.translatesAutoresizingMaskIntoConstraints = false
        picture.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return picture
    }()

    let postLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Публикаций"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    let subsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписчиков"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    let subbedLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Подписок"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    lazy var profileName: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = DataManager.OurDataManager.currentUser.profileDescription
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    lazy var cityInfo: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Казань"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    lazy var postCounter: UILabel = {
        var myView = UILabel()
        myView.text = "\(DataManager.OurDataManager.syncGetCurrentUserPosts().count)"
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.font = UIFont.boldSystemFont(ofSize: 16)
        return myView
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(PictureCell.self, forCellWithReuseIdentifier: PictureCell.identifier)
        return collectionView
    }()

    lazy var subsCounter: UILabel = {
        var myView = UILabel()
        myView.text = "1234"
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.font = UIFont.boldSystemFont(ofSize: 16)
        return myView
    }()

    lazy var subbedCounter: UILabel = {
        var myView = UILabel()
        myView.text = "1337"
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.font = UIFont.boldSystemFont(ofSize: 16)
        return myView
    }()

    lazy var editUserInfoButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Редактировать профиль", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    func reloadData() {
        self.datasource = DataManager.OurDataManager.syncGetCurrentUserPosts()
        self.collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupUI()
        view.backgroundColor = .white
        let curUser = DataManager.OurDataManager.getCurrentUser()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: curUser.userName, style: .plain, target: self, action: nil)
        print(navigationItem.leftBarButtonItem?.title)
        navigationItem.title = ""
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)], for: [])
    }

    func addSubViews() {
        view.addSubview(profilePic)
        view.addSubview(profileName)
        view.addSubview(cityInfo)
        view.addSubview(postCounter)
        view.addSubview(postLabel)
        view.addSubview(subsCounter)
        view.addSubview(subsLabel)
        view.addSubview(subbedCounter)
        view.addSubview(subbedLabel)
        view.addSubview(collectionView)
        view.addSubview(editUserInfoButton)
    }
    func setupUI() {
        NSLayoutConstraint.activate([
            profilePic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            profilePic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profilePic.widthAnchor.constraint(equalToConstant: 100),
            profilePic.heightAnchor.constraint(equalToConstant: 100),
            profileName.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 10),
            profileName.leadingAnchor.constraint(equalTo: profilePic.leadingAnchor),
            cityInfo.topAnchor.constraint(equalTo: profileName.bottomAnchor),
            cityInfo.leadingAnchor.constraint(equalTo: profileName.leadingAnchor),
            postCounter.centerYAnchor.constraint(equalTo: profilePic.centerYAnchor, constant: -8),
            postCounter.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 50),
            postCounter.widthAnchor.constraint(equalToConstant: 64),
            postLabel.topAnchor.constraint(equalTo: postCounter.bottomAnchor),
            postLabel.leadingAnchor.constraint(equalTo: profilePic.trailingAnchor, constant: 16),
            subsLabel.centerYAnchor.constraint(equalTo: postLabel.centerYAnchor),
            subsLabel.leadingAnchor.constraint(equalTo: postLabel.trailingAnchor, constant: 12),
            subsCounter.centerYAnchor.constraint(equalTo: postCounter.centerYAnchor),
            subsCounter.centerXAnchor.constraint(equalTo: subsLabel.centerXAnchor),
            subbedLabel.centerYAnchor.constraint(equalTo: postLabel.centerYAnchor),
            subbedLabel.leadingAnchor.constraint(equalTo: subsLabel.trailingAnchor, constant: 12),
            subbedCounter.centerYAnchor.constraint(equalTo: subsCounter.centerYAnchor),
            subbedCounter.centerXAnchor.constraint(equalTo: subbedLabel.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: editUserInfoButton.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            editUserInfoButton.topAnchor.constraint(equalTo: cityInfo.bottomAnchor, constant: 20),
            editUserInfoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            editUserInfoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        profilePic.layer.masksToBounds = true
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
    }

    internal static var shared = ViewController()
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(controller: self), animated: true)
    }
}
