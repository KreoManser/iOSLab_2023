//
//  ShopView.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 23.11.2023.
//

import UIKit

class ShopView: UIView {
    var shopController: ShopViewController?
    var player = Player.sigelton
    var level1Buyed: Bool = true
    var level2Buyed: Bool = false
    var level3Buyed: Bool = false
    var level4Buyed: Bool = false
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Space"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Магазин"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    lazy var level1ImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "StarShip1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var level2ImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "StarShip2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var level3ImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "StarShip3"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var level4ImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "StarShip4"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var levelTitel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корабль - «Revelation»"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelTite2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корабль - «Thanatos»"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelTite3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корабль - «Providence»"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelTite4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корабль - «Avatar»"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelSubTite1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hp: 2, damage: 1"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelSubTite2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hp: 2, damage: 2"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelSubTite3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hp: 6, damage: 2"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelSubTite4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hp: 8, damage: 3"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    lazy var levelButton1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("100", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        let action = UIAction {_ in
            self.buyFirstLevel()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var levelButton2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("500", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        let action = UIAction {_ in
            self.buySecondeLevel()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var levelButton3: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("1000", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        let action = UIAction {_ in
            self.buyThirdLevel()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var levelButton4: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("2000", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        let action = UIAction {_ in
            self.buyFourthLevel()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Главный экран", for: .normal)
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 25
        let action = UIAction {_ in
            self.shopController!.dismisShopController()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundImageView)
        addSubview(level1ImageView)
        addSubview(level2ImageView)
        addSubview(level3ImageView)
        addSubview(level4ImageView)
        addSubview(levelTitel)
        addSubview(levelTite2)
        addSubview(levelTite3)
        addSubview(levelTite4)
        addSubview(levelSubTite1)
        addSubview(levelSubTite2)
        addSubview(levelSubTite3)
        addSubview(levelSubTite4)
        addSubview(levelButton1)
        addSubview(levelButton2)
        addSubview(levelButton3)
        addSubview(levelButton4)
        setUpLayout()
        setupLayoutlevel1()
        setupLayoutlevel2()
        setupLayoutlevel3()
        setupLayoutlevel4()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ShopView {
    func allertVCPresintation(allertText: String) {
        let allertVC = UIAlertController(title: "Внимание!", message: allertText, preferredStyle: .alert)
        let cancelAllertButton = UIAlertAction(title: "Закрыть", style: .cancel)
        allertVC.addAction(cancelAllertButton)
        shopController?.present(allertVC, animated: true)
    }
}

extension ShopView {
    func buyFirstLevel() {
        if (player.getCredits()) >= 100 {
            if !level1Buyed {
                player.upgradePlayer(level: .level1 )
                allertVCPresintation(allertText: "Капитан! Вы успешно купили этот борт")
                level1Buyed = true
                player.setCredits(credits: (player.getCredits()) - 100)
            } else {
                allertVCPresintation(allertText: "Капитан! Этот борт уже вами куплен")
            }
        } else {
            allertVCPresintation(allertText: "Капитан! У вас нет денег")
        }
    }
    func buySecondeLevel() {
        if player.getCredits() >= 500 {
            if !level2Buyed && level1Buyed {
                player.upgradePlayer(level: .level2)
                allertVCPresintation(allertText: "Капитан! Вы успешно купили этот борт")
                level2Buyed = true
                player.setCredits(credits: (player.getCredits()) - 500)
            } else {
                if level2Buyed {
                    allertVCPresintation(allertText: "Капитан! Этот борт уже вами куплен")
                } else {
                    allertVCPresintation(allertText: "Капитан! Вами не куплен предыдущий борт")
                }
            }
        } else {
            allertVCPresintation(allertText: "Капитан! У вас нет денег")
        }
    }
    func buyThirdLevel() {
        if (player.getCredits()) >= 1000 {
            if !level3Buyed && level2Buyed {
                player.upgradePlayer(level: .level3)
                allertVCPresintation(allertText: "Капитан! Вы успешно купили этот борт")
                level3Buyed = true
                player.setCredits(credits: (player.getCredits()) - 1000)
            } else {
                if level3Buyed {
                    allertVCPresintation(allertText: "Капитан! Этот борт уже вами куплен")
                } else {
                    allertVCPresintation(allertText: "Капитан! Вами не куплен предыдущий борт")
                }
            }
        } else {
            allertVCPresintation(allertText: "Капитан! У вас нет денег")
        }
    }
    func buyFourthLevel() {
        if (player.getCredits()) >= 2000 {
            if !level4Buyed && level3Buyed {
                player.upgradePlayer(level: .level4)
                allertVCPresintation(allertText: "Капитан! Вы успешно купили этот борт")
                level4Buyed = true
                player.setCredits(credits: (player.getCredits()) - 2000)
            } else {
                if level4Buyed {
                    allertVCPresintation(allertText: "Капитан! Этот борт уже вами куплен")
                } else {
                    allertVCPresintation(allertText: "Капитан! Вами не куплен предыдущий борт")
                }
            }
        } else {
            allertVCPresintation(allertText: "Капитан! У вас нет денег")
        }
    }
}

extension ShopView {
    func setUpLayout() {
        addSubview(menuLabel)
        addSubview(menuButton)
        NSLayoutConstraint.activate([
            menuLabel.bottomAnchor.constraint(
                equalTo: level1ImageView.topAnchor, constant: -20),
            menuLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuButton.topAnchor.constraint(equalTo: level4ImageView.bottomAnchor, constant: 20),
            menuButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuButton.heightAnchor.constraint(equalToConstant: 50),
            menuButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    func setupLayoutlevel1() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(
                equalTo: topAnchor, constant: 0),
            backgroundImageView.bottomAnchor.constraint(
                equalTo: bottomAnchor, constant: 10),
            backgroundImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor, constant: 0),
            level1ImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor, constant: 150),
            level1ImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            level1ImageView.widthAnchor.constraint( equalToConstant: 80),
            level1ImageView.heightAnchor.constraint( equalToConstant: 80),
            levelTitel.topAnchor.constraint(
                equalTo: level1ImageView.topAnchor, constant: 10),
            levelTitel.leadingAnchor.constraint(
                equalTo: level1ImageView.trailingAnchor, constant: 10),
            levelSubTite1.topAnchor.constraint(
                equalTo: levelTitel.bottomAnchor, constant: 10),
            levelSubTite1.leadingAnchor.constraint(
                equalTo: level1ImageView.trailingAnchor, constant: 10),
            levelButton1.topAnchor.constraint(
                equalTo: levelTitel.bottomAnchor, constant: 10),
            levelButton1.leadingAnchor.constraint(
                equalTo: levelSubTite1.trailingAnchor, constant: 15),
            levelButton1.widthAnchor.constraint( equalToConstant: 100),
            levelButton1.heightAnchor.constraint( equalToConstant: 20)
        ])
    }
    func setupLayoutlevel2() {
        NSLayoutConstraint.activate([
            level2ImageView.topAnchor.constraint(
                equalTo: level1ImageView.bottomAnchor, constant: 20),
            level2ImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            level2ImageView.widthAnchor.constraint( equalToConstant: 80),
            level2ImageView.heightAnchor.constraint( equalToConstant: 80),
            levelTite2.topAnchor.constraint(
                equalTo: level2ImageView.topAnchor, constant: 10),
            levelTite2.leadingAnchor.constraint(
                equalTo: level2ImageView.trailingAnchor, constant: 10),
            levelSubTite2.topAnchor.constraint(equalTo: levelTite2.bottomAnchor, constant: 10),
            levelSubTite2.leadingAnchor.constraint(
                equalTo: level2ImageView.trailingAnchor, constant: 10),
            levelButton2.topAnchor.constraint(
                equalTo: levelTite2.bottomAnchor, constant: 10),
            levelButton2.leadingAnchor.constraint(
                equalTo: levelSubTite2.trailingAnchor, constant: 15),
            levelButton2.widthAnchor.constraint(equalToConstant: 100),
            levelButton2.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    func setupLayoutlevel3() {
        NSLayoutConstraint.activate([
            level3ImageView.heightAnchor.constraint(equalToConstant: 80),
            level3ImageView.topAnchor.constraint(
                equalTo: level2ImageView.bottomAnchor, constant: 20),
            level3ImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            level3ImageView.widthAnchor.constraint(equalToConstant: 80),
            level3ImageView.heightAnchor.constraint(equalToConstant: 90),
            levelTite3.topAnchor.constraint(equalTo: level3ImageView.topAnchor, constant: 10),
            levelTite3.leadingAnchor.constraint(
                equalTo: level3ImageView.trailingAnchor, constant: 10),
            levelSubTite3.topAnchor.constraint(equalTo: levelTite3.bottomAnchor, constant: 10),
            levelSubTite3.leadingAnchor.constraint(
                equalTo: level3ImageView.trailingAnchor, constant: 10),
            levelButton3.topAnchor.constraint(
                equalTo: levelTite3.bottomAnchor, constant: 10),
            levelButton3.leadingAnchor.constraint(
                equalTo: levelSubTite3.trailingAnchor, constant: 15),
            levelButton3.widthAnchor.constraint(equalToConstant: 100),
            levelButton3.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    func setupLayoutlevel4() {
        NSLayoutConstraint.activate([
            level4ImageView.heightAnchor.constraint(equalToConstant: 80),
            level4ImageView.topAnchor.constraint(
                equalTo: level3ImageView.bottomAnchor, constant: 20),
            level4ImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            level4ImageView.widthAnchor.constraint(equalToConstant: 80),
            level4ImageView.heightAnchor.constraint(equalToConstant: 90),
            levelTite4.topAnchor.constraint(
                equalTo: level4ImageView.topAnchor, constant: 10),
            levelTite4.leadingAnchor.constraint(
                equalTo: level4ImageView.trailingAnchor, constant: 10),
            levelSubTite4.topAnchor.constraint(
                equalTo: levelTite4.bottomAnchor, constant: 10),
            levelSubTite4.leadingAnchor.constraint(
                equalTo: level4ImageView.trailingAnchor, constant: 10),
            levelButton4.topAnchor.constraint(
                equalTo: levelTite4.bottomAnchor, constant: 10),
            levelButton4.leadingAnchor.constraint(
                equalTo: levelSubTite4.trailingAnchor, constant: 15),
            levelButton4.widthAnchor.constraint(equalToConstant: 100),
            levelButton4.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
