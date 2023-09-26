import Foundation

internal class Fruit {
    let image: UIImage?
    let name: String
    let price: String
    
    init(image: UIImage?, name: String, price: String) {
        self.image = image
        self.name = name
        self.price = price
    }
}
