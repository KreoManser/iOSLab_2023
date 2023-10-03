import Foundation

struct Task: Hashable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var dateOfAdd: Date
}
