import Foundation
import UIKit

struct Post: Equatable {
    let id: Int
    let image: UIImage
    let caption: String
    let date: Date
    var countOfLikes: Int
}
