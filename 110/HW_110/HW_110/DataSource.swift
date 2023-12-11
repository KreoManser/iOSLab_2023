import UIKit
class DataSource {
    static let shared = DataSource()
    var user1 = User()
    var user2 = User()
    var user3 = User()
    static var photosDictionary: [String: [Photo]] = [:]
    var userData: [User] = []
    var friendsData: [(String, UIImage)] = [
        ("CrazyCat", .twoCats),
        ("WorkCat", .avatar),
        ("WhiteCat", .whitecat)
    ]
    func getUsers() -> [User] {
        return userData
    }
    func addUsers() {
        userData.append(user1)
        userData.append(user2)
        userData.append(user3)
        DataSource.photosDictionary["CrazyCat"] = photoDataSource1
        DataSource.photosDictionary["WhiteCat"] = photoDataSource2
        DataSource.photosDictionary["WorkCat"] = photoDataSource3

    }
    public var photoDataSource3: [Photo] = [
        Photo()
    ]

    public var photoDataSource2: [Photo] = [
        Photo()
    ]
    public var photoDataSource1: [Photo] = [
        Photo()
    ]
}
