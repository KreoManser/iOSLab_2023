import Foundation

struct Task: Hashable, Identifiable {
    let id: UUID
    var title: String
    var description: String
    var creationDate: Date
}
