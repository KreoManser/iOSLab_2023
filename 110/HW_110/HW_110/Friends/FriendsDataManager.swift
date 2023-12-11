import UIKit
class FriendsDataManager: NSObject {
    static var shared = FriendsDataManager()
    let dataManager = ProfileDataManager.shared
    var users = DataSource.shared.getUsers()
    var friendsData: [User] = []
    private override init() {
        super.init()
    }
    func setData(currentUser: User) {
        friendsData = users.filter { user in
           user.login != currentUser.login
        }
    }
    func clearData() {
        friendsData.removeAll()
    }
}
