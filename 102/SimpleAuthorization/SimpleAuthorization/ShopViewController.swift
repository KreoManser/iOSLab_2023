import UIKit

class ShopViewController: UIViewController {

    @IBOutlet var shopLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        shopLabel.clipsToBounds = true
        shopLabel.layer.cornerRadius = 25
    }
}
