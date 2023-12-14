//
//  ProfileCollectionDataSOurce.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 31.10.2023.
//

import UIKit

class ProfileCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    let dataManager = DataManager.sigelton
    let coreDataManger = CoreDataManager.shared
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataManger.getPostsAuthorizationUser().count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                    for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        let item = coreDataManger.getPostsAuthorizationUser()[indexPath.row]
        cell.imageView.image = UIImage(named: item.postPhotoNmae!)
        return cell
    }
}
