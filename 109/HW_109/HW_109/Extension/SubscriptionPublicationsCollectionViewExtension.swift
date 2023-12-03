import UIKit
extension SubscriptionPublicationsDataManager: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.photosSubscribers.count
    }
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            var photo: Photo
            photo = dataManager.photosSubscribers[indexPath.row]
            guard let cell = collectionView
                .dequeueReusableCell(
                    withReuseIdentifier: SubsPublicationsCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? SubsPublicationsCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let count = dataManager.getCountLike(photoId: photo.id)
            cell.configure(with: photo, count: count)
            cell.delegate = self
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, layout
                        collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 500)
    }
}
