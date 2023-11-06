//
//  PublicationsUIView.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import UIKit

class ProfileTimelineView: UIView, UICollectionViewDelegateFlowLayout {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let colleсtionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        colleсtionView.register(TimelineCollectionViewCell.self, forCellWithReuseIdentifier: TimelineCollectionViewCell.reuseIdentificator)
        colleсtionView.delegate = self
        colleсtionView.translatesAutoresizingMaskIntoConstraints = false
        return colleсtionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        collectionView.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    weak var controller: ProfileTimelineViewController?

    private func setupLayout() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func scroll(_ index: IndexPath) {
        collectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
    }

    func setupDataSource(_ dataSource: ProfileTimelineDataSource) {
        collectionView.dataSource = dataSource
    }

    func reloadData() {
        collectionView.reloadData()
    }
}

extension ProfileTimelineView {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {

            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
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

extension ProfileTimelineView: AlertDelegate {

    func didPressAlert(id: Int) {
        let alert = UIAlertController(title: "Уведомление", message: "Удалить?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Ок", style: .default) {_ in
            self.controller?.acyncDelete(id: id)
            self.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        controller?.present(alert)
    }

}
