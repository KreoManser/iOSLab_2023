//
//  MainProfileCatGram.swift
//  CatGram
//
//  Created by Нияз Ризванов on 28.10.2023.
//

import UIKit

class MainProfileCatGramView: UIView, UICollectionViewDelegateFlowLayout {
    weak var controller: ViewController?
    lazy var buttonForRefactorProfile: UIButton = {
        var action = UIAction { _ in
            //
        }
        let button = UIButton(type: .custom)
        let buttonImage = UIImage(named: "ThreePoints")
        button.setImage(buttonImage, for: .normal)
        button.addAction(action , for: .touchUpInside)
        return button
    }()
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var textPublication: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Publication"
        return text
    }()
    lazy var numberPublication: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        text.text = "10"
        return text
    }()
    lazy var textSubscribers: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Subscribers"
        return text
    }()
    lazy var numberSubscribers: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        text.text = "10"
        return text
    }()
    lazy var textSubscriptions: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.systemFont(ofSize: 12)
        text.text = "Subscriptions"
        return text
    }()
    lazy var numberSubscriptions: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .white
        text.font = UIFont.boldSystemFont(ofSize: 17)
        text.text = "10"
        return text
    }()
    lazy var descriptionCanal: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .white
        text.text = "Мой блог"
        return text
    }()
    lazy var gridCollectionView: UICollectionView = {
        // Здесь вы можете настроить размеры ячеек и расстояния между ними
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 110, height: 100)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: GridCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        if let image = UIImage(named: "avatarCat"){
            avatarImage.image = image
        }
        avatarImage.layer.cornerRadius = 40
        avatarImage.clipsToBounds = true
        
        addSubview(avatarImage)
        addSubview(descriptionCanal)
        
        addSubview(gridCollectionView)
        
        setupLayout()
        setupNavigationBar()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        let mainStacklView_1 = createVerticalStackView([textPublication, numberPublication])
            let mainStacklView_2 = createVerticalStackView([textSubscribers, numberSubscribers])
            let mainStacklView_3 = createVerticalStackView([textSubscriptions, numberSubscriptions])
            addSubview(mainStacklView_1)
            addSubview(mainStacklView_2)
            addSubview(mainStacklView_3)
            
            NSLayoutConstraint.activate([
                avatarImage.widthAnchor.constraint(equalToConstant: 80),
                avatarImage.heightAnchor.constraint(equalToConstant: 80),
                avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                avatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                mainStacklView_1.trailingAnchor.constraint(equalTo: mainStacklView_2.leadingAnchor, constant: -10),
                mainStacklView_1.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStacklView_1.widthAnchor.constraint(equalToConstant: 80),
                mainStacklView_1.heightAnchor.constraint(equalToConstant: 40),
                mainStacklView_2.trailingAnchor.constraint(equalTo: mainStacklView_3.leadingAnchor, constant: -10),
                mainStacklView_2.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStacklView_2.widthAnchor.constraint(equalToConstant: 80),
                mainStacklView_2.heightAnchor.constraint(equalToConstant: 40),
                mainStacklView_3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                mainStacklView_3.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                mainStacklView_3.widthAnchor.constraint(equalToConstant: 80),
                mainStacklView_3.heightAnchor.constraint(equalToConstant: 40),
                descriptionCanal.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
                descriptionCanal.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                descriptionCanal.trailingAnchor.constraint(equalTo: trailingAnchor),
                gridCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                gridCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                gridCollectionView.topAnchor.constraint(equalTo: descriptionCanal.bottomAnchor, constant: 15),
                gridCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -10)
        ])
    }
    func createVerticalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }
    func setupNavigationBar(){
        let customBarButtonItem = UIBarButtonItem(customView: buttonForRefactorProfile )
        controller?.navigationItem.rightBarButtonItem = customBarButtonItem
        controller?.navigationItem.title = "Cat_Boss"
        controller?.navigationItem.titleView?.tintColor = .white
        controller?.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
extension MainProfileCatGramView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifier, for: indexPath) as! GridCell
        
        return cell
    }
}

extension MainProfileCatGramView: UICollectionViewDelegate {
    // Обработка выбора ячейки, если это необходимо
}
class GridCell: UICollectionViewCell {
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Настройка визуальных элементов вашей ячейки (например, добавьте label)
        
        contentView.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GridCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
