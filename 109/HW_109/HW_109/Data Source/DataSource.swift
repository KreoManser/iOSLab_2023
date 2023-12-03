import UIKit
class DataSource {
    static let shared = DataSource()
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
        Photo(id: "WorkCat_6", image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar, day: "1", month: "июня", year: "2020"),
        Photo(id: "WorkCat_5", image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar, day: "20", month: "апреля", year: "2020"),
        Photo(id: "WorkCat_4", image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar, day: "16", month: "декабря", year: "2019"),
        Photo(id: "WorkCat_3", image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar, day: "5", month: "ноября", year: "2019"),
        Photo(id: "WorkCat_2", image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar, day: "15", month: "октября", year: "2019"),
        Photo(id: "WorkCat_1", image: .avatar, like: false,
              comment: "Воркаю", author: "WorkCat", avatar: .avatar, day: "1", month: "декабря", year: "2018")
    ]

    public var photoDataSource2: [Photo] = [
        Photo(id: "WhiteCat_6", image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat, day: "13", month: "декабря", year: "2021"),
        Photo(id: "WhiteCat_5", image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat, day: "21", month: "ноября", year: "2021"),
        Photo(id: "WhiteCat_4", image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat, day: "22", month: "октября", year: "2021"),
        Photo(id: "WhiteCat_3", image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat, day: "11", month: "сентября", year: "2021"),
        Photo(id: "WhiteCat_2", image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat, day: "12", month: "июня", year: "2021"),
        Photo(id: "WhiteCat_1", image: .whitecat, like: false,
              comment: "Отдыхаю", author: "WhiteCat", avatar: .whitecat, day: "16", month: "апреля", year: "2021")
    ]
    public var photoDataSource1: [Photo] = [
        Photo(id: "CrazyCat_6", image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats, day: "14", month: "июня", year: "2023"),
        Photo(id: "CrazyCat_5", image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats, day: "26", month: "мая", year: "2023"),
        Photo(id: "CrazyCat_4", image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats, day: "21", month: "апреля", year: "2023"),
        Photo(id: "CrazyCat_3", image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats, day: "5", month: "марта", year: "2022"),
        Photo(id: "CrazyCat_2", image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats, day: "3", month: "февраля", year: "2022"),
        Photo(id: "CrazyCat_1", image: .twoCats, like: false,
              comment: "С кентом", author: "CrazyCat", avatar: .twoCats, day: "1", month: "января", year: "2022")
    ]
}
