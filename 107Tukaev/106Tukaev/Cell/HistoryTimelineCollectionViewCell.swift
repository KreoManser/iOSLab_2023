//
//  HistoryTableViewCell.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import UIKit

class HistoryTimelineCollectionViewCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCollectionViewCell.reuseIdentificator)
        collectionView.register(PublicationCollectionViewCell.self, forCellWithReuseIdentifier: TimelineCollectionViewCell.reuseIdentificator)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(_ datasource: HistoryDataSource) {
        collectionView.dataSource = datasource
    }

    private func setupLayout() {
        contentView.addSubview(collectionView)

        let content = contentView.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: content.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: content.bottomAnchor)
        ])
    }

    static var reuseIdentificator: String {
        return String(describing: self)
    }
}
