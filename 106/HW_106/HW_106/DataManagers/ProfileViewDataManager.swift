import Foundation
import UIKit

class ProfileViewDataManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    typealias Model = Photo
    static let shared = ProfileViewDataManager()
    weak var controller = ProfileViewController()
    var photos: [Photo] = []
    private override init() {
        super.init()
        photos = generateTestData()
    }
    private func generateTestData() -> [Photo] {
        var testData: [Photo] = []
        for i in 1...10 {
            let photo =  Photo(id: UUID().uuidString, image: .avatar)
            testData.append(photo)
        }
        return testData
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = controller?.profileView.collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.reuseIdentifier, for: indexPath) as? ProfileCollectionViewCell {
            let photo = photos[indexPath.row]
            cell.configure(with: photo)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
