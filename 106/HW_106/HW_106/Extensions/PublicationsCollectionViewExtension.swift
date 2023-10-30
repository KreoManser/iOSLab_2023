import Foundation
import UIKit
extension PublicationsDataManager: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PublicationCollectionViewCell.reuseIdentifier, for: indexPath) as? PublicationCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let photo = dataManager.photos[indexPath.row]
        cell.configure(with: photo)
        cell.delegate = self
        cell.optionsTapped = { [weak self] alertController in
            self?.funcButtonTapped!(alertController)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 500)
    }
}
