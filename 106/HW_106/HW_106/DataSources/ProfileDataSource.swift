import UIKit

class ProfileDataSource {
    public var photoDataSource: [Photo] = [
        Photo(id: UUID().uuidString, image: .chineseCat, like: false, comment: "Котфуций"),
        Photo(id: UUID().uuidString, image: .avatar, like: false, comment: "Работаю"),
        Photo(id: UUID().uuidString, image: .whitecat, like: false, comment: "Отдыхаю"),
        Photo(id: UUID().uuidString, image: .twoCats, like: false, comment: "С кентом"),
        Photo(id: UUID().uuidString, image: .chineseCat, like: false, comment: "Котфуций"),
        Photo(id: UUID().uuidString, image: .avatar, like: false, comment: "Работаю"),
        Photo(id: UUID().uuidString, image: .whitecat, like: false, comment: "Отдыхаю"),
        Photo(id: UUID().uuidString, image: .twoCats, like: false, comment: "С кентом")
    ]

}
