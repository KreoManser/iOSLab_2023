import Foundation
class StoriesDataManager: NSObject {
    static var shared = StoriesDataManager()
    let dataManager = ProfileDataManager.shared
    private override init() {
        super.init()
    }
}
