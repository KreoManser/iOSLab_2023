import UIKit

class ProductTableViewCell: UITableViewCell {
    private lazy var productImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var addInBusketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(named: "busket"), for: button.state)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(with product: Product){
        productImageView.image = product.productImage
        titleLabel.text = product.name
        priceLabel.text = String(product.price)
        priceLabel.textColor = .red
        priceLabel.font = .italicSystemFont(ofSize: 16)
    }
    private  func setupLayout(){
        addAllSubViews()
        allConstraints()
    }
    private func addAllSubViews(){
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addInBusketButton)
    }
    private func allConstraints(){
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: 70),
            productImageView.widthAnchor.constraint(equalToConstant: 70),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: productImageView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            priceLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 120),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            addInBusketButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            addInBusketButton.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 10),
            addInBusketButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            addInBusketButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            addInBusketButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            addInBusketButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
}
extension ProductTableViewCell{
    static var reuseIdentifier: String{
        return String(describing: self )
    }
}
