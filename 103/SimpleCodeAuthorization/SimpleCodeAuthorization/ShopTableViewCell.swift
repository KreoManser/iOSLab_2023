import UIKit

class ShopTableViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.numberOfLines = 0
        return text
    }()

    lazy var catImageView: UIImageView = {
        let image = UIImageView ()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        catImageView.image = nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with product: Product) {
        catImageView.image = product.catImage
        nameLabel.text = product.name
    }
    
    func setupLayout() {
        
        guard catImageView.superview == nil else { return }

        contentView.addSubview(catImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            //  Ограничения для catImageView
            catImageView.heightAnchor.constraint(equalToConstant: 80.0),
            catImageView.widthAnchor.constraint(equalToConstant: 80.0),
            catImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            catImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            catImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            //  Ограничения для nameLabel
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: catImageView.bottomAnchor)
            
        ])
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

