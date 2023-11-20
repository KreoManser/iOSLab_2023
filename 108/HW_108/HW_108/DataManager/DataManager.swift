import Foundation

class DataManager {
    weak var delegate: DataManagerDelegate?
    var spaceshipHP = 3
    func changeHP() {
        if spaceshipHP > 0 {
            spaceshipHP -= 1
        } else {
            delegate?.gameOver()
        }
    }
}
