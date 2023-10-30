import Foundation
import UIKit

class ProfileViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataManager.shared.syncGetPosts().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier,
        for: indexPath) as? ProfileCollectionViewCell
        let post = DataManager.shared.syncGetPosts()[indexPath.row]
        cell?.configureCell(post)

        return cell!
    }
}
