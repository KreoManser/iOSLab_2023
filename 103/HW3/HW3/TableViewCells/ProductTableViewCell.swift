import UIKit

class ProductTableViewCell: UITableViewCell {
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImageView.image = nil
        productNameLabel.text = nil
        productCountLabel.text = nil
        productPriceLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(product: Product) {
        productImageView.image = product.image
        productNameLabel.text = product.name
        productPriceLabel.text = product.price
        productCountLabel.text = product.count
    }
    
    func setupLayout() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(productCountLabel)
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            productImageView.heightAnchor.constraint(equalToConstant: 100),
            productImageView.widthAnchor.constraint(equalToConstant: 100),
            
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            productNameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            productCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            productCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10)
        ])
    }
}
