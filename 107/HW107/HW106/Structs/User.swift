import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let password: String
    let avatarImageName: String
    let description: String
    let subsCount: String
    let followsCount: String
    var likedPosts: [Int] = []
}
