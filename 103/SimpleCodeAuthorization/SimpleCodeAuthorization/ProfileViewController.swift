import UIKit

class ProfileViewController: UIViewController {

    var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "аваКот")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    var nameText: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Yazgul Khasanshina"
        text.textAlignment = .center
        text.backgroundColor = .systemBrown
        text.textColor = UIColor.white
        return text
    }()
    var numberText: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "8-800-555-35-35"
        text.textAlignment = .center
        text.backgroundColor = .systemBrown
        text.textColor = UIColor.white
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = .white
        
        let OKButton = createButton(title: "OK")
        let firstButton = createButton(title: "!!!")
        let secondButton = createButton(title: "???")
        let thirdButton = createButton(title: "***")
        let fourthButton = createButton(title: "$$$")
        let basketButton = createButton(title: "Basket")
        let shopButton = createButton(title: "Shop")
                
        OKButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        basketButton.addTarget(self, action: #selector(pushToBasket), for: .touchUpInside)
        shopButton.addTarget(self, action: #selector(pushToShop), for: .touchUpInside)

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        let horizontalStackView1row = createHorizontalStackView()
        let horizontalStackView2row = createHorizontalStackView()
        
        horizontalStackView1row.addArrangedSubview(firstButton)
        horizontalStackView1row.addArrangedSubview(secondButton)
        horizontalStackView2row.addArrangedSubview(thirdButton)
        horizontalStackView2row.addArrangedSubview(fourthButton)
        
        stackView.addArrangedSubview(horizontalStackView1row)
        stackView.addArrangedSubview(horizontalStackView2row)
        
        view.addSubview(imageView)
        view.addSubview(nameText)
        view.addSubview(numberText)
        view.addSubview(OKButton)
        view.addSubview(basketButton)
        view.addSubview(shopButton)
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let textHeight: CGFloat = 30.0
        let textdWidth: CGFloat = 300.0
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            // Ограничения для imageView
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -400),

            // Ограничения для nameText
            nameText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameText.widthAnchor.constraint(equalToConstant: textdWidth),
            nameText.heightAnchor.constraint(equalToConstant: textHeight),
            
            // Ограничения для numberText
            numberText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 10),
            numberText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberText.widthAnchor.constraint(equalToConstant: textdWidth),
            numberText.heightAnchor.constraint(equalToConstant: textHeight),
            
            // Ограничения для basketButton
            basketButton.topAnchor.constraint(equalTo: numberText.bottomAnchor, constant: 20),
            basketButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketButton.widthAnchor.constraint(equalToConstant: 100.0),
            basketButton.heightAnchor.constraint(equalToConstant: 40.0),
            
            // Ограничения для stackView
            stackView.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 100.0),
            stackView.heightAnchor.constraint(equalToConstant: 40.0),
            
            // Ограничения для shopButton
            shopButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            shopButton.bottomAnchor.constraint(equalTo: OKButton.topAnchor, constant: -20),
            shopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shopButton.widthAnchor.constraint(equalToConstant: 100.0),
            shopButton.heightAnchor.constraint(equalToConstant: 40.0),
            
            // Ограничения для OKButton
            OKButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
            OKButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            OKButton.widthAnchor.constraint(equalToConstant: 100.0),
            OKButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }
    
    @objc func pushToBasket() {
        let basketVC = BasketViewController()
        self.navigationController?.pushViewController(basketVC, animated: true)
    }
    @objc func pushToShop() {
        let shopVC = ShopViewController()
        self.navigationController?.pushViewController(shopVC, animated: true)
    }
    @objc func okButtonAction() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
}
