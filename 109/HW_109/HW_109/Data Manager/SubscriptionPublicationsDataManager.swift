import Foundation
class SubscriptionPublicationsDataManager: NSObject, SubsPublicationsCellDelegate {
    static var shared = SubscriptionPublicationsDataManager()
    let dataManager = ProfileDataManager.shared
    private override init() {
        super.init()
    }
    func setLikeInData(photo: Photo) {
        dataManager.likeCount[dataManager.user?.login ?? "", default: []].append(photo.id)
    }
    func removeLikeFromData(photo: Photo) {
        if var authorLikes = dataManager.likeCount[dataManager.user?.login ?? ""]
            , let index = authorLikes.firstIndex(of: photo.id) {
            authorLikes.remove(at: index)
            dataManager.likeCount[dataManager.user?.login ?? ""] = authorLikes
        }
    }
}
