import UIKit
protocol UpdateProfileDataManagerDelegate: AnyObject {
    func dataDidChange()
}
class ProfileDataManager: NSObject {
    typealias Model = Photo
    private let dataSource = ProfileDataSource()
    internal var photos: [Photo] = []
    static let shared = ProfileDataManager()
    weak var delegate: UpdateProfileDataManagerDelegate?
    internal let saveQueue = OperationQueue()
    internal let getModelsQueue = OperationQueue()
    internal let deleteQueue = OperationQueue()
    internal let findModelQueue = OperationQueue()
    weak var navigationController: UINavigationController?
    private override init() {
        super.init()
        add()
    }
    func updateUI() {
        delegate?.dataDidChange()
    }
    func add() {
        for index in 0..<8 {
            photos.append(dataSource.photoDataSource[index])
        }
    }
}

