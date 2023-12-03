import Foundation
import UIKit

struct Post: Equatable {
    let id: Int
    let image: UIImage
    let caption: String
    let date: Date
    var countOfLikes: Int

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
