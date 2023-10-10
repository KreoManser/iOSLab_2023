import UIKit

/// Кастомная ячейка для таблички с машинами.
internal class CarTableViewCell: UITableViewCell {
    ///  Идентификатор для переиспользования ячейки.
    static let reuseIdentifier = "CarCell";
    
    /// Картинка  машины
    lazy var carImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.frame = CGRectMake(image.frame.origin.x, image.frame.origin.y, 80, 80);
        image.contentMode = .scaleAspectFit;

        return image;
    }()
    
    /// Название машины
    lazy var nameLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.font = .boldSystemFont(ofSize: 20);
        
        return label;
    }()
    
    /// Цена машины
    lazy var priceLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;

        return label
    }()
    
    /// Кнопка для добавления в корзину
    /// (для ShoppingCartViewController выступает в качестве кнопки удаления, просто с другим названием)
    /// кнопка по итогу не нажимается (не знаю как исправить)
    lazy var addButton: UIButton = {
        let button = UIButton(type: .system);
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.setTitle("Add to cart", for: .normal);

        return button;
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);

        addSubview(carImageView);
        addSubview(nameLabel);
        addSubview(priceLabel);
        addSubview(addButton);
        bringSubviewToFront(addButton);
        
        NSLayoutConstraint.activate([
            carImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            carImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            carImageView.widthAnchor.constraint(equalToConstant: 80),
            carImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            priceLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
}
