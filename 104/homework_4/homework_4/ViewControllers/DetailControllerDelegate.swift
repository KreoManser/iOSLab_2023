import UIKit

internal protocol DetailControllerDelegate: AnyObject {
    func dataUpdate(for task: Task);
}

