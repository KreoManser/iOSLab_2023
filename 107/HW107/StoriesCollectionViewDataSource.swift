import Foundation
import UIKit

class StoriesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DataManager.shared.getAllUsersPosts().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCollectionViewCell.reuseIdentifier,
        for: indexPath) as? StoryCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        let story = DataManager.shared.getAllStories()[indexPath.row]
        cell.configureCell(story)

        return cell
    }
}
