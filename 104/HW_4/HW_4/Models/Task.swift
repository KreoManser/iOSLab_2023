import Foundation

enum Priority: Int {
    case low = 0
    case medium = 1
    case high = 2
}

struct Task: Hashable, Identifiable {
    var id: UUID
    var name: String
    var description: String
    var dateOfAdd: Date
    var priority: Priority
    
    init(name: String, description: String, dateOfAdd: Date, priority: Priority) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.dateOfAdd = Date()
        self.priority = priority
    }
}
