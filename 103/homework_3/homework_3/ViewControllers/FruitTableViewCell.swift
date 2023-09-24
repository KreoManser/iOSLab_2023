import UIKit

internal class FruitTableViewCell: UITableViewCell{
    
    private lazy var fruitImageView: UIImageView = {
        let image = UIImageView();
        image.contentMode = .scaleAspectFill;
        image.frame = CGRectMake(image.frame.origin.x, image.frame.origin.y, 50, 50);
        image.translatesAutoresizingMaskIntoConstraints = false;
        
        return image;
    }()
        
    private lazy var fruitNameLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .black;
        
        return label;
    }()
    
    private lazy var fruitPriceLabel: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.textColor = .black;
        
        return label;
    }()
    
    internal static var reuseIdentifier: String {
        return String(describing: self);
    }
    
    private func addSubviews(){
        contentView.addSubview(fruitImageView);
        contentView.addSubview(fruitNameLabel);
        contentView.addSubview(fruitPriceLabel);
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
           fruitImageView.heightAnchor.constraint(equalToConstant: 50),
           fruitImageView.widthAnchor.constraint(equalToConstant: 50),
           fruitImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
           fruitImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
           
           fruitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
           fruitNameLabel.leadingAnchor.constraint(equalTo: fruitImageView.trailingAnchor, constant: 10),
           fruitNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
           
           fruitPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
           fruitPriceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
       ])
    }
    
    func configureCell(with fruit: Fruit) {
        fruitImageView.image = fruit.image;
        fruitNameLabel.text = fruit.name;
        fruitPriceLabel.text = fruit.price;
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        let backgroundView = UIView();
        backgroundView.backgroundColor = UIColor.systemGray3;
        backgroundView.layer.cornerRadius = 5;
        self.backgroundView = backgroundView;
        
        addSubviews();
        setConstraints();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    override func prepareForReuse() {
        super.prepareForReuse();
        
        fruitImageView.image = nil;
    }
}
