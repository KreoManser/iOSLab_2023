import Foundation

struct Task: Hashable {
    let id: UUID
    var name: String
    let description: String
    let dateOfAdd: Date
}
