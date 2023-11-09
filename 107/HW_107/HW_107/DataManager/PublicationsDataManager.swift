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
    /// не совсем понимаю что тут нужно сделать чтобы избавиться от предупрежедения
    func deleteItem(photo: Photo) async {
        Task {
            do {
                try await dataManager.asyncDelete(model: photo)
                updateUI()
            }
        }
    }
    func updateUI() {
        updateDelegate?.dataDidChange()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            sortedPublications = dataManager.photosProfile
            updateUI()
        } else {
            Task {
                let photos = await dataManager.asyncFind(model: searchText)
                self.sortedPublications = []
                for photo in photos {
                    self.sortedPublications.append(Photo(
                        id: photo.id, image: photo.image,
                        like: photo.like, comment: photo.comment, author: photo.author, avatar: photo.avatar))
                }
                self.updateUI()
            }
        }
    }
}
