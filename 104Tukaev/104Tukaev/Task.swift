import Foundation
import UIKit

struct Task: Hashable, Identifiable{
    let id: UUID
    let name: String
    let description: String
    let ProductImage: UIImage?
    
    init(id: UUID, name: String, description: String, ProductImage: UIImage?) {
        self.id = id
        self.name = name
        self.description = description
        self.ProductImage = ProductImage
    }
}
