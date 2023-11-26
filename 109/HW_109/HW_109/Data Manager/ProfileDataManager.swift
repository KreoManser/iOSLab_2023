import UIKit
protocol UpdateProfileDataManagerDelegate: AnyObject {
    func dataDidChange()
}
class ProfileDataManager: NSObject {
    typealias Model = Photo
    private let dataSource = DataSource()
    var user: User?
    var photosProfile: [Photo] = []
    var photosSubscribers: [Photo] = []
    static let shared = ProfileDataManager()
    weak var delegate: UpdateProfileDataManagerDelegate?
    let saveQueue = DispatchQueue(label: "saveQueue")
    let getModelsQueue = DispatchQueue(label: "getModelsQueue")
    let deleteQueue = DispatchQueue(label: "deleteQueue")
    let findModelQueue = DispatchQueue(label: "findModelQueue")
    weak var navigationController: UINavigationController?
    private override init() {
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setPhotos(user: User) {
        self.user = user
        let key = user.login
        let photodict = DataSource.photosDictionary
        for photos in DataSource.photosDictionary {
            if photos.key == key {
                for photo in photos.value {
                    self.photosProfile.append(photo)
                }
            } else {
                for photo in photos.value {
                    self.photosSubscribers.append(photo)
                }
            }
        }
    }
    func updateUI() {
        delegate?.dataDidChange()
    }
}
