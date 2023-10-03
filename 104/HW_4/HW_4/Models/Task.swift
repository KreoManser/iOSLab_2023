import Foundation

struct Task: Hashable, Identifiable {
    let id: UUID
    var name: String
    let description: String
    let dateOfAdd: Date
}
