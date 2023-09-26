import UIKit

class CategoryTableViewCell: UITableViewCell {
    private lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    private lazy var categoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .medium)
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryImageView.image = nil
        categoryNameLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(category: Category) {
        categoryImageView.image = category.image
        categoryNameLabel.text = category.name
    }
    
    func setupLayout() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryNameLabel)
        
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            categoryImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            categoryNameLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 10),
            categoryNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
