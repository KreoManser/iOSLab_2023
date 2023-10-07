import UIKit

class ShopTableViewCell: UITableViewCell {

    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var firstLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var secondLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var colorLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with product: Product){
        productImageView.image = product.ProductImage
        firstLabel.text = product.name
        secondLabel.text = product.price
        colorLabel.text = product.color
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            
            productImageView.image = nil
        }
}

extension ShopTableViewCell {
    
    private func setupLayout(){
        
        guard productImageView.superview == nil else { return }
        
        let mainStackView = UIStackView(arrangedSubviews: [firstLabel, secondLabel])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(productImageView,mainStackView, colorLabel)
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 30),
            productImageView.widthAnchor.constraint(equalToConstant: 30),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorLabel.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            colorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func addSubviews(_ subviews: UIView...) {
        subviews.forEach { contentView.addSubview($0) }
    }
    
    static var reuseIdentifier: String {
           return String(describing: self)
       }
}
