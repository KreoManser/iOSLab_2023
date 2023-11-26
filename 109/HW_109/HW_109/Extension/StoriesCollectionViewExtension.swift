import UIKit
extension StoriesDataManager: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
                    withReuseIdentifier: StoriesCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? StoriesCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configure(with: photo)
            return cell
        }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 148)
    }
}
