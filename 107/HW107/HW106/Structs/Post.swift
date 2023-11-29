import Foundation
import UIKit

struct Post: Codable, Equatable {
    let id: Int
    let postImageName: String
    let postDescription: String
    let postDate: String
}
