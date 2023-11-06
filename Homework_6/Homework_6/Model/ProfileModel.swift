import UIKit

struct Post: Equatable, Identifiable {
    let id: UUID
    let image: UIImage?
    let description: String
    let date: String
}
