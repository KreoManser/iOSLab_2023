import Foundation
class SubscriptionPublicationsDataManager: NSObject {
    static var shared = SubscriptionPublicationsDataManager()
    let dataManager = ProfileDataManager.shared
    private override init() {
        super.init()
    }
}
