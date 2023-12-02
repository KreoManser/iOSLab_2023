//
//  TimelineView.swift
//  107Tukaev
//
//  Created by surexnx on 05.11.2023.
//

import UIKit

class TimelineView: UIView, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let colleсtionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let forCellWithReuseIdentifier = HistoryTimelineCollectionViewCell.reuseIdentificator

        colleсtionView.register(HistoryTimelineCollectionViewCell.self, forCellWithReuseIdentifier: forCellWithReuseIdentifier)

        colleсtionView.register(TimelineCollectionViewCell.self, forCellWithReuseIdentifier: TimelineCollectionViewCell.reuseIdentificator)
        colleсtionView.delegate = self
        colleсtionView.translatesAutoresizingMaskIntoConstraints = false
        return colleсtionView
    }()

    func setupDataSource(dataSource: TimelineDataSource) {
        collectionView.dataSource = dataSource
    }
    func reloadData() {
        collectionView.reloadData()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews(_ subview: UIView...) {
        subview.forEach { addSubview($0) }
    }

    weak var controller: TimelineViewController?

    private func setupLayout() {
        addSubviews(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TimelineView {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 100)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

extension TimelineView: ProfilePushDelegate {
    func didPressImage(userId: Int) {
        controller?.navigationController?.pushViewController(FriendsViewController(userId: userId), animated: false)
    }

}
