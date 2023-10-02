import Foundation
struct Task: Hashable, Identifiable  {
    var id: UUID
    let title: String
    let shortDescription: String
    let fullDescription:String
}
