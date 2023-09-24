
import UIKit

class StoreTableViewCell: UITableViewCell {
    
    private lazy var storeImageView: UIImageView = {
        let storeImageView = UIImageView()
        storeImageView.translatesAutoresizingMaskIntoConstraints = false
        return storeImageView
    }()
    
    private lazy var titleLabelView: UILabel = {
        let titleLabelView = UILabel()
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        titleLabelView.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabelView.textColor = .purple
        return titleLabelView
    }()
    
    private lazy var dataTitleLabelView: UILabel = {
        let dataTitleLabelView = UILabel()
        dataTitleLabelView.numberOfLines = 0
        dataTitleLabelView.translatesAutoresizingMaskIntoConstraints = false
        dataTitleLabelView.font = UIFont.boldSystemFont(ofSize: 9.0)
        dataTitleLabelView.textColor = .purple
        return dataTitleLabelView
    }()
    
    private lazy var creatorLabel: UILabel = {
        let creatorLabel = UILabel()
        creatorLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        creatorLabel.textColor = .purple
        return creatorLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    override func prepareForReuse() {
        storeImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configerCell(with store: Store) {
        storeImageView.image = store.image
        creatorLabel.text = store.creator
        titleLabelView.text = store.title
        dataTitleLabelView.text = store.subTitle
        
    }

    private func setupLayout() {
        
        guard storeImageView.superview == nil else { return }
        let mainStackView = UIStackView(arrangedSubviews: [titleLabelView, dataTitleLabelView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(storeImageView)
        contentView.addSubview(mainStackView)
        contentView.addSubview(creatorLabel)
        
        NSLayoutConstraint.activate([
            storeImageView.heightAnchor.constraint(equalToConstant: 70),
            storeImageView.widthAnchor.constraint(equalToConstant: 70),
            storeImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            storeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: storeImageView.bottomAnchor, constant: 3),
            mainStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

//            creatorLabel.leadingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            creatorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            creatorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

extension StoreTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
