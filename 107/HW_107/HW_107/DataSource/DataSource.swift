import UIKit
class DataSource {
    var user1 = User(
        id: UUID().uuidString,
        login: "WorkCat",
        password: "0000",
        avatar: .avatar,
        fullName: "Кот Михайлович"
    )
    var user2 = User(
        id: UUID().uuidString,
        login: "WhiteCat",
        password: "1111",
        avatar: .whitecat,
        fullName: "Кошка Викторовна"
    )
    var user3 = User(
        id: UUID().uuidString,
        login: "CrazyCat",
        password: "2222",
        avatar: .twoCats,
        fullName: "Кот Орный"
    )
    static var photosDictionary: [String: [Photo]] = [:]
    var userData: [User] = []
    func addUsers() {
        userData.append(user1)
        userData.append(user2)
        userData.append(user3)

        DataSource.photosDictionary["WorkCat"] = photoDataSource1
        DataSource.photosDictionary["WhiteCat"] = photoDataSource2
        DataSource.photosDictionary["CrazyCat"] = photoDataSource3
    }
    public var photoDataSource1: [Photo] = [
        Photo(id: UUID().uuidString, image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar),
        Photo(id: UUID().uuidString, image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar),
        Photo(id: UUID().uuidString, image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar),
        Photo(id: UUID().uuidString, image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar),
        Photo(id: UUID().uuidString, image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar),
        Photo(id: UUID().uuidString, image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar)
    ]

    public var photoDataSource2: [Photo] = [
        Photo(id: UUID().uuidString, image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat),
        Photo(id: UUID().uuidString, image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat),
        Photo(id: UUID().uuidString, image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat),
        Photo(id: UUID().uuidString, image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat),
        Photo(id: UUID().uuidString, image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat),
        Photo(id: UUID().uuidString, image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat)
    ]
    public var photoDataSource3: [Photo] = [
        Photo(id: UUID().uuidString, image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats),
        Photo(id: UUID().uuidString, image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats),
        Photo(id: UUID().uuidString, image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats),
        Photo(id: UUID().uuidString, image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats),
        Photo(id: UUID().uuidString, image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats),
        Photo(id: UUID().uuidString, image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats)
    ]
}
