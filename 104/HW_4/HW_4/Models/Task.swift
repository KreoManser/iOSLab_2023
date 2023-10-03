import Foundation

enum Priority: String {
    case low = "Low priority"
    case medium = "Medium priority"
    case high = "High priority"
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
