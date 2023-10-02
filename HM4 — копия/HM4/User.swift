import Foundation
import UIKit

struct User: Hashable, Identifiable {
    let id: UUID
    let name: String
    let lastName: String
}
