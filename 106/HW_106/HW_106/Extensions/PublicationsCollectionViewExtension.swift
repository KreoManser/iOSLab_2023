import UIKit
extension PublicationsDataManager: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sortedPublications.isEmpty {
            return dataManager.photos.count
        } else {
            return sortedPublications.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var photo: Photo
        if sortedPublications.isEmpty {
            photo = dataManager.photos[indexPath.row]
        } else {
            photo = sortedPublications[indexPath.row]
        }

        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PublicationCollectionViewCell.reuseIdentifier, for: indexPath) as? PublicationCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(with: photo)
        cell.delegate = self
        cell.optionsTapped = { [weak self] alertController in
            self?.funcButtonTapped?(alertController)
        }
        return cell
    }
    /// метод sizeForItemAt снёс как вы показывали, не понимаю почему ошибка осталась
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 500)
    }
}
