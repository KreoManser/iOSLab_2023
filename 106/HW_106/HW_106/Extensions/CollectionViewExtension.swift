import UIKit

extension ProfileDataManager: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let publicationsViewController = PublicationsViewController()
        publicationsViewController.selectedPublication = indexPath.row
        self.navigationController?.pushViewController(publicationsViewController, animated: true)
    }
}
