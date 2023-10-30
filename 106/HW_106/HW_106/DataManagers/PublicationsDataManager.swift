import Foundation
import UIKit
protocol UpdatePublicationsDataManagerDelegate: AnyObject {
    func dataDidChange()
}
class PublicationsDataManager: NSObject, PublicationCollectionViewCellDelegate {
    var funcButtonTapped: ((_ alertController: UIAlertController) -> Void)?
    static var shared = PublicationsDataManager()
    let dataManager = ProfileDataManager.shared
    weak var deleteDelegate: PublicationCollectionViewCellDelegate?
    weak var updateDelegate: UpdatePublicationsDataManagerDelegate?
    private override init() {
        super.init()
    }
    func deleteItem(photo: Photo) {
        dataManager.asyncDelete(model: photo, completion: { result in
            switch result {
            case .success:
                print("Удаление выполнено успешно")
            case .failure(let error):
                print("Ошибка: \(error)")
            }
        })
        updateUI()
    }
    func updateUI() {
        updateDelegate?.dataDidChange()
    }
}

