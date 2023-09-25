import UIKit

class ProfileViewController: UIViewController {
    
    private var imageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "avatar"))
            imageView.layer.cornerRadius = 50
            imageView.layer.masksToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    private lazy var nameLabelView: UILabel = {
        let nameLabelView = UILabel()
        nameLabelView.translatesAutoresizingMaskIntoConstraints = false
        nameLabelView.font = UIFont.boldSystemFont(ofSize: 30.0)
        nameLabelView.text = "Козлов Руслан"
        nameLabelView.textColor = .black
        return nameLabelView
    }()
    private lazy var numberLabelView: UILabel = {
        let numberLabelView = UILabel()
        numberLabelView.translatesAutoresizingMaskIntoConstraints = false
        numberLabelView.font = UIFont.boldSystemFont(ofSize: 30.0)
        numberLabelView.text = "88005553535"
        numberLabelView.textColor = .gray
        return numberLabelView
    }()
    
    
    
    private lazy var buttonBasketView: UIButton = {
        let buttonBasketView = UIButton()
        buttonBasketView.translatesAutoresizingMaskIntoConstraints = false
        buttonBasketView.backgroundColor = .systemGray4
        buttonBasketView.layer.cornerRadius = 10.0
        buttonBasketView.setTitle("Корзина", for: .normal)
        buttonBasketView.setTitleColor(.black, for: .normal)
        buttonBasketView.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        buttonBasketView.addTarget(self, action: #selector(ToBasketViewController), for: .touchDown)
        return buttonBasketView
    }()
    
    private lazy var storeButtonView: UIButton = {
        let storeButtonView = UIButton()
        storeButtonView.translatesAutoresizingMaskIntoConstraints = false
        storeButtonView.backgroundColor = .systemGray4
        storeButtonView.layer.cornerRadius = 10.0
        storeButtonView.setTitle("Магазин", for: .normal)
        storeButtonView.setTitleColor(.black, for: .normal)
        storeButtonView.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        storeButtonView.addTarget(self, action: #selector(toStoreViewController), for: .touchDown)
        return storeButtonView
    }()
    
    private lazy var exitButtonView: UIButton = {
        let exitButtonView = UIButton()
        exitButtonView.translatesAutoresizingMaskIntoConstraints = false
        exitButtonView.backgroundColor = .systemGray4
        exitButtonView.layer.cornerRadius = 10.0
        exitButtonView.setTitle("Выйти", for: .normal)
        exitButtonView.setTitleColor(.black, for: .normal)
        exitButtonView.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        exitButtonView.addTarget(self, action: #selector(exitToFirstViewController), for: .touchDown)
        return exitButtonView
    }()
    
    private lazy var stackView: UIStackView = {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    @objc private func exitToFirstViewController() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    @objc private func ToBasketViewController() {
        let basketViewController = BasketViewController()
        self.navigationController?.pushViewController(basketViewController, animated: true)
    }
    @objc private func toStoreViewController() {
        let storeViewController = StoreViewController()
        self.navigationController?.pushViewController(storeViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        view.addSubview(imageView)
        setupUI()
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])


    }
    
    private func setupUI() {
        
        view.addSubview(nameLabelView)
        view.addSubview(numberLabelView)
        view.addSubview(buttonBasketView)
        view.addSubview(exitButtonView)
        view.addSubview(storeButtonView)
        
        let button1 = addNothingButton()
        let button2 = addNothingButton()
        let button3 = addNothingButton()
        let button4 = addNothingButton()
        let array: [UIButton] = [ button1, button2, button3, button4 ]
        for item in array {
            view.addSubview(item)
        }
        
        NSLayoutConstraint.activate([
            nameLabelView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            numberLabelView.topAnchor.constraint(equalTo: nameLabelView.bottomAnchor, constant: 6),
            numberLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonBasketView.topAnchor.constraint(equalTo: numberLabelView.bottomAnchor, constant: 10),
            buttonBasketView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBasketView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -83),
            buttonBasketView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 83),
            
            button1.topAnchor.constraint(equalTo: buttonBasketView.bottomAnchor, constant: 10),
            button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 83),
            button1.widthAnchor.constraint(equalToConstant: 100),
            
            button2.topAnchor.constraint(equalTo: buttonBasketView.bottomAnchor, constant: 10),
            button2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -83),
            button2.widthAnchor.constraint(equalToConstant: 100),
            
            button3.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 10),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.widthAnchor.constraint(equalToConstant: 100),
            
            button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 10),
            button4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button4.widthAnchor.constraint(equalToConstant: 100),
            
            storeButtonView.topAnchor.constraint(equalTo: button4.bottomAnchor, constant: 10),
            storeButtonView.widthAnchor.constraint(equalToConstant: 223),
            storeButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

//            exitButtonView.topAnchor.constraint(equalTo: storeButtonView.bottomAnchor),
            exitButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            exitButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButtonView.widthAnchor.constraint(equalToConstant: 223),
        ])
    }
    private func addNothingButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10.0
        button.setTitle("Что-то", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        return button
    }
    
}

