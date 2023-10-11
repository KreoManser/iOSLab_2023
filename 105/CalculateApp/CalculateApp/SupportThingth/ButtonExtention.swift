import UIKit

/// Create functions for default buttons
extension UIButton {
    /// Set properties for view of buttons with numbers
    /// - Parameter title: text that will show in button's label
    func setNumberButton(title: String) {
        var config = createBaseConfiguration(title: title)
        config.baseBackgroundColor = UIColor(red: 80/255.0, green: 80/255.0, blue: 80/255.0, alpha: 1)
        self.configuration = config
    }
    
    /// Set properties for view of buttons with operations in right side
    /// - Parameter title: text that will show in button's label
    func setOperationRigthButton(title: String) {
        var config = createBaseConfiguration(title: title)
        config.baseBackgroundColor = UIColor(red: 1, green: 149/255.0, blue: 0, alpha: 1)
        self.configuration = config
    }
    
    /// Set properties for view of buttons with operations in up side
    /// - Parameter title: text that will show in button's label
    func setOperationUpButton(title: String) {
        var config = createBaseConfiguration(title: title)
        config.baseBackgroundColor = UIColor(red: 212/255.0, green: 212/255.0, blue: 210/255.0, alpha: 1)
        config.baseForegroundColor = .black
        self.configuration = config
    }
    
    /// Set properties for view of buttons with operations that will show in horizontal orientation
    /// - Parameter title: text that will show in button's label
    func setOperationHorizontalButton(title: String) {
        var config = createBaseConfiguration(title: title)
        config.baseBackgroundColor = UIColor(red: 28/255.0, green: 28/255.0, blue: 28/255.0, alpha: 1)
        self.configuration = config
    }
    
    /// Create Default configuration for button
    /// - Parameter title: title of button
    /// - Returns: configuration of button
    private func createBaseConfiguration(title: String) -> Configuration {
        let size = calculateSizeOfButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .white
        configuration.title = title
        configuration.background.cornerRadius = CGFloat(size) / 2.0
        return configuration
    }
    
    /// Support func to calculate size of button
    /// - Returns: size of button
    private func calculateSizeOfButton() -> Double {
        let width = UIScreen.main.bounds.size.width + 44
        var size = Double(width) / 4.0
        let sizeViaButtons = (size * 11) / 100.0
        size -= sizeViaButtons * 2
        return size
    }
}
