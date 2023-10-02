
import Foundation
import UIKit

struct Store: Hashable, Identifiable {
    let id: UUID = UUID()
    let image: UIImage?
    let title: String
    let subTitle: String
    let creator: String
    
}

