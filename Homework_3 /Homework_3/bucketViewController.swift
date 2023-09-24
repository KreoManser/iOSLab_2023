import UIKit

class BucketViewController: UIViewController {
    
    lazy var basketStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Корзина пуста"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()

    lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 5
        button.setTitleColor(.darkText, for: .normal)
        button.setTitle("Оплатить", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Корзина"
    }

    private func setupLayout() {

        
        view.addSubview(basketStatusLabel)
        view.addSubview(payButton)

        NSLayoutConstraint.activate([
           

            basketStatusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            basketStatusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

           
            payButton.heightAnchor.constraint(equalToConstant: 35),
            payButton.widthAnchor.constraint(equalToConstant: 222),
            payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
