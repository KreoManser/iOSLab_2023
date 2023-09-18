import UIKit

class BasketViewController: UIViewController {

    @IBOutlet var basketLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        basketLabel.clipsToBounds = true
        basketLabel.layer.cornerRadius = 25
    }
}
