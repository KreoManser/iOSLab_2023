import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)

        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 30
    }
    
    @IBAction func unwindToProfileVC (_ sender: UIStoryboardSegue) {
    }
    
}
