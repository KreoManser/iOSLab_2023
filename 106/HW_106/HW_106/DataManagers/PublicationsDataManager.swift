import UIKit
protocol UpdatePublicationsDataManagerDelegate: AnyObject {
    func dataDidChange()
}
class PublicationsDataManager: NSObject, PublicationCollectionViewCellDelegate, UISearchBarDelegate {
    var funcButtonTapped: ((_ alertController: UIAlertController) -> Void)?
    var likeButtonTapped: ((_ alertController: UIAlertController) -> Void)?
    static var shared = PublicationsDataManager()
    let dataManager = ProfileDataManager.shared
    var sortedPublications: [Photo] = []
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            sortedPublications = dataManager.photos
            updateUI()
        } else {
            dataManager.asyncFind(model: searchText, completion: { [weak self] result in
                switch result {
                case .success(let publications):
                    self?.sortedPublications = []
                    for publication in publications {
                        print(publication.comment)
                        self?.sortedPublications.append(Photo(
                            id: publication.id, image: publication.image,
                            like: publication.like, comment: publication.comment))
                    }
                    self?.updateUI()
                case .failure(let error):
                    print("Ошибка получения постов: \(error)")
                }

            })
        }
    }
}

