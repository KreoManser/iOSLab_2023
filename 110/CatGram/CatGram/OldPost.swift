import Foundation
import UIKit

struct OldPost: Equatable {
    let id: Int
    let image: UIImage
    let caption: String
    let date: Date
    var countOfLikes: Int

    static func == (lhs: OldPost, rhs: OldPost) -> Bool {
        return lhs.id == rhs.id
    }
}
