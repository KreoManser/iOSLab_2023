import Foundation
import UIKit

class ProfileDataSource {
    public var photoDataSource: [Photo] = [
        Photo(id: UUID().uuidString, image: .chineseCat, like: false, comment: "12"),
        Photo(id: UUID().uuidString, image: .chineseCat, like: false, comment: "12"),
        Photo(id: UUID().uuidString, image: .chineseCat, like: false, comment: "12"),
        Photo(id: UUID().uuidString, image: .chineseCat, like: false, comment: "12")
    ]

}
