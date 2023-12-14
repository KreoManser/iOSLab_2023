//
//  NewaLineCollectionDataSource.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 07.12.2023.
//

import UIKit

class NewsLineCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let coreDataManager = CoreDataManager.shared
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataManager.obtaineSavedData().count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "newsLineCollectionCell",
            for: indexPath) as? NewsLineCollectionViewCell else {return UICollectionViewCell()}
        let item = coreDataManager.obtaineSavedData()[indexPath.row]
        cell.contentView.layer.masksToBounds = true
        cell.avatarImageView.image = UIImage(named: item.userAvatarImageName!)
        cell.nameLabel.text = item.userName
        return cell
    }
}
