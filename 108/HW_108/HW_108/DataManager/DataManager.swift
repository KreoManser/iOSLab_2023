import Foundation

class DataManager: NSObject {
    static let shared = DataManager()
    weak var delegate: DataManagerDelegate?
    var difficult = 1
    var spaceshipHP = 4
    var currentWave = 1
    var countWave = 4
    var aliensHP = 1
    var bossHP = 25
    private override init() {
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func changeHP() {
        if spaceshipHP > 0 {
            spaceshipHP -= 1
        } else {
            delegate?.gameOver()
        }
    }
    func checkDifficult() {
        switch difficult {
        case 1:
            aliensHP = 1
            bossHP = 25
            countWave = 4
        case 2:
            aliensHP = 2
            bossHP = 30
            countWave = 4
        case 3:
            aliensHP = 2
            bossHP = 35
            countWave = 6
        default:
            print("This is an unknown difficult")
        }
    }
}
