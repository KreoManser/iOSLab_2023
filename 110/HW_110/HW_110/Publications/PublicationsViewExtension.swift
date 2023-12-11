import UIKit
extension PublicationsDataManager: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sortedPublications.isEmpty {
            return dataManager.photosProfile.count
        } else {
            return sortedPublications.count
        }
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        var photo: Photo
        if sortedPublications.isEmpty {
            photo = dataManager.photosProfile[indexPath.row]
        } else {
            photo = sortedPublications[indexPath.row]
        }
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: PublicationCollectionViewCell.reuseIdentifier,
                for: indexPath) as? PublicationCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let count = dataManager.getCountLike(photoId: UUID().uuidString)
        cell.configure(with: photo, count: count)
        cell.delegate = self
        cell.alert = { [weak self] alertController in
            self?.funcButtonTapped?(alertController)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath:
                        IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 500)
    }
}
