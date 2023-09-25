import UIKit

class BasketViewController: UIViewController {
    
    var OKButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .systemBrown
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var basketText: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Basket"
        text.textAlignment = .center
        text.backgroundColor = .systemBrown
        text.textColor = UIColor.white
        return text
    }()

    lazy var stackViewImage: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        view.backgroundColor = .white
        
        OKButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
    
        let barbieCatLabel = createLabel(title: "Barbie")
        let sumBarbieCatLabel = createLabel(title: "1011$")
        let setCatLabel = createLabel(title: "Set")
        let sumSetCatLabel = createLabel(title: "1100$")
        let kenCatLabel = createLabel(title: "Ken")
        let sumKenCatLabel = createLabel(title: "1010$")
        
        view.addSubview(basketText)
        view.addSubview(OKButton)
        view.addSubview(stackViewImage)
        view.addSubview(barbieCatLabel)
        view.addSubview(sumBarbieCatLabel)
        view.addSubview(setCatLabel)
        view.addSubview(sumSetCatLabel)
        view.addSubview(kenCatLabel)
        view.addSubview(sumKenCatLabel)
        
        let barbieCatImageView = UIImageView(image: UIImage(named: "msCat"))
        let setCatImageView = UIImageView(image: UIImage(named: "3in1Cats"))
        let kenCatImageView = UIImageView(image: UIImage(named: "mrCat"))
        stackViewImage.addArrangedSubview(barbieCatImageView)
        stackViewImage.addArrangedSubview(setCatImageView)
        stackViewImage.addArrangedSubview(kenCatImageView)
        
        let textHeight: CGFloat = 30.0
        let textdWidth: CGFloat = 100.0
        let safeArea = view.safeAreaLayoutGuide
        let widthImage: CGFloat = 100.0
        let heightImage: CGFloat = 80.0

        
        NSLayoutConstraint.activate([
            
            // Ограничения для numberText
            basketText.topAnchor.constraint(equalTo: safeArea.topAnchor),
            basketText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            basketText.widthAnchor.constraint(equalToConstant: 700.0),
            basketText.heightAnchor.constraint(equalToConstant: textHeight),

            // Ограничения для OKButton
            OKButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -50),
            OKButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            OKButton.widthAnchor.constraint(equalToConstant: 100.0),
            OKButton.heightAnchor.constraint(equalToConstant: 40.0),
            
//            Ограничения для stackView
            stackViewImage.topAnchor.constraint(equalTo: basketText.bottomAnchor, constant: 10),
            stackViewImage.bottomAnchor.constraint(equalTo: OKButton.topAnchor, constant: -10),
            stackViewImage.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackViewImage.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),

            // Ограничения для изображений внутри stackView
            barbieCatImageView.widthAnchor.constraint(equalToConstant: widthImage),
            barbieCatImageView.heightAnchor.constraint(equalToConstant: heightImage),
            
            setCatImageView.widthAnchor.constraint(equalToConstant: widthImage),
            setCatImageView.heightAnchor.constraint(equalToConstant: heightImage),
            
            kenCatImageView.widthAnchor.constraint(equalToConstant: widthImage),
            kenCatImageView.heightAnchor.constraint(equalToConstant: heightImage),
            
//            Ограничения для barbieCatLabel
            barbieCatLabel.bottomAnchor.constraint(equalTo: barbieCatImageView.centerYAnchor),
            barbieCatLabel.leadingAnchor.constraint(equalTo: barbieCatImageView.trailingAnchor, constant: 20),
            barbieCatLabel.widthAnchor.constraint(equalToConstant: textdWidth),
            barbieCatLabel.heightAnchor.constraint(equalToConstant: textHeight),
            
//            Ограничения для sumBarbieCatLabel
            sumBarbieCatLabel.bottomAnchor.constraint(equalTo: barbieCatImageView.centerYAnchor),
            sumBarbieCatLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 20),
            sumBarbieCatLabel.widthAnchor.constraint(equalToConstant: textdWidth),
            sumBarbieCatLabel.heightAnchor.constraint(equalToConstant: textHeight),
            
//            Ограничения для setCatLabel
            setCatLabel.bottomAnchor.constraint(equalTo: setCatImageView.centerYAnchor),
            setCatLabel.leadingAnchor.constraint(equalTo: setCatImageView.trailingAnchor, constant: 20),
            setCatLabel.widthAnchor.constraint(equalToConstant: textdWidth),
            setCatLabel.heightAnchor.constraint(equalToConstant: textHeight),
            
//            Ограничения для sumSetCatLabel
            sumSetCatLabel.bottomAnchor.constraint(equalTo: setCatImageView.centerYAnchor),
            sumSetCatLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 20),
            sumSetCatLabel.widthAnchor.constraint(equalToConstant: textdWidth),
            sumSetCatLabel.heightAnchor.constraint(equalToConstant: textHeight),
            
//            Ограничения для kenCatLabel
            kenCatLabel.bottomAnchor.constraint(equalTo: kenCatImageView.centerYAnchor),
            kenCatLabel.leadingAnchor.constraint(equalTo: kenCatImageView.trailingAnchor, constant: 20),
            kenCatLabel.widthAnchor.constraint(equalToConstant: textdWidth),
            kenCatLabel.heightAnchor.constraint(equalToConstant: textHeight),
            
//            Ограничения для sumKenCatLabel
            sumKenCatLabel.bottomAnchor.constraint(equalTo: kenCatImageView.centerYAnchor),
            sumKenCatLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 20),
            sumKenCatLabel.widthAnchor.constraint(equalToConstant: textdWidth),
            sumKenCatLabel.heightAnchor.constraint(equalToConstant: textHeight),
        ])
        
    }
    
    @objc func okButtonAction() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func createLabel(title: String) -> UILabel {
        let text = UILabel ()
        text.text = title
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = UIColor.brown
        return text
    }
    
}
