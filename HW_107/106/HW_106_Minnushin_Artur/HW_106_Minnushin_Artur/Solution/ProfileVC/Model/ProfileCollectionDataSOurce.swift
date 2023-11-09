//
//  ProfileCollectionDataSOurce.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 31.10.2023.
//

import UIKit

class ProfileCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var posts: [PostInfo] = []
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                    for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        let item = posts[indexPath.row]
        cell.imageView.image = UIImage(named: item.postPhotoNmae)
        return cell
    }
}
