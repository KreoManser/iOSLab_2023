import Foundation
import UIKit
class FriendsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var dataManager = CoreDataManager.shared
    var user: User

    init(user: User) {
        self.user = user
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManager.getUserPubl(user: user).count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 0 {
            let withReuseIdentifier = ProfileCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as? ProfileCollectionViewCell
            if let cell = cell {
                let subBut = dataManager.getSubBut(user: user)
                cell.user = user
                cell.subDelegate = collectionView.superview as? any SubscribeDelegate
                cell.setupSub(subBut: subBut)
                cell.subTap = {
                    cell.setupSub(subBut: subBut)
                }
                cell.configureFriendCell(with: user)
                return cell
            }
            return UICollectionViewCell()

        } else {

            let withReuseIdentifier = PublicationCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as? PublicationCollectionViewCell

            if let cell = cell {
                let publication = dataManager.getUserPubl(user: user)[indexPath.row]
                cell.configureCell(with: publication)
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
