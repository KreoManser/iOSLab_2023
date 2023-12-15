import Foundation
import UIKit

class ProfileViewDataSource: NSObject, UICollectionViewDataSource {
    private let posts = CoreDataManager.shared.getPostsFromCurUser()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier,
        for: indexPath) as? ProfileCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        let post = posts[indexPath.row]
        cell.configureCell(post)

        return cell
    }
}
