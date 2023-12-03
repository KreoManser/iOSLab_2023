//
//  NewsLineView.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 01.12.2023.
//

import UIKit

class NewsLineView: UIView {
    lazy var newsLineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CatGram"
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    lazy var newsLineCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: "newsLineCollectionCell")
        return collectionView
    }()
    lazy var newsLineTablewView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "newsLineTableCell")
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(newsLineLabel)
        addSubview(newsLineCollectionView)
        addSubview(newsLineTablewView)
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            newsLineLabel.topAnchor.constraint(equalTo: topAnchor, constant: 65),
            newsLineLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            newsLineCollectionView.topAnchor.constraint(equalTo: newsLineLabel.bottomAnchor, constant: 20),
            newsLineCollectionView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            newsLineCollectionView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            newsLineTablewView.topAnchor.constraint(
                equalTo: newsLineCollectionView.bottomAnchor, constant: 20),
            newsLineTablewView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            newsLineTablewView.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            newsLineTablewView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension NewsLineView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0,
                      height: 100.0)
    }
}
