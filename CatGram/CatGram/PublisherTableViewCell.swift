import UIKit
protocol PublisherCellDelegate: AnyObject {
    func postDeleted(at indexPath: IndexPath?)
}


class PublisherTableViewCell: UITableViewCell {
    var currentPublisher: Publisher?
    weak var delegate: PublisherCellDelegate?
    var indexPath: IndexPath?
    
    private lazy var imageAvatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "photo1")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var labelName: UILabel = {
        let label = UILabel()
        label.text = "Cat_boss"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonThreePoint: UIButton = {
        let action = UIAction { _ in
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                    
            
            let deleteAction = UIAlertAction(title: "Удалить пост", style: .destructive) { _ in
                guard let newIndexPath = self.indexPath else{return}
                if let publisher = self.currentPublisher {
                    Manager.asyncDelete(publisher) { [weak self] success in
                        if success {
    
                            self?.delegate?.postDeleted(at: self?.indexPath)
                        } else {
                            print("Произошла ошибка при удалении")
                        }
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
                   
            
            if let viewController = self.delegate as? UIViewController {
                viewController.present(alertController, animated: true, completion: nil)
            }
        }
        let button = UIButton(type: .custom, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "threePoints"), for: .normal)
        return button
    }()
    
    private lazy var photoPublisher: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var heartIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heartIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var messageIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "messageIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var planeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "planeIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var favoriteIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "favoriteIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private lazy var descriptionPublisher: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    private lazy var datePublisher: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 8)
        label.textColor = .white
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoPublisher.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.addSubview(imageAvatar)
        contentView.addSubview(labelName)
        contentView.addSubview(buttonThreePoint)
        contentView.addSubview(photoPublisher)
        contentView.addSubview(descriptionPublisher)
        contentView.addSubview(datePublisher)
        contentView.addSubview(favoriteIcon)
        
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        let iconsStackView = UIStackView(arrangedSubviews: [heartIcon,messageIcon,planeIcon])
        iconsStackView.translatesAutoresizingMaskIntoConstraints = false
        iconsStackView.axis = .horizontal
        iconsStackView.alignment = .leading
        iconsStackView.distribution = .fillEqually
        iconsStackView.spacing = 5
        
        contentView.addSubview(iconsStackView)
        
        NSLayoutConstraint.activate([
            imageAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            imageAvatar.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            imageAvatar.widthAnchor.constraint(equalToConstant: 20),
            imageAvatar.heightAnchor.constraint(equalToConstant: 20),
            labelName.leadingAnchor.constraint(equalTo: imageAvatar.trailingAnchor, constant: 10),
            labelName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            buttonThreePoint.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            buttonThreePoint.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            photoPublisher.topAnchor.constraint(equalTo: imageAvatar.bottomAnchor, constant: 10),
            photoPublisher.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoPublisher.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoPublisher.heightAnchor.constraint(equalToConstant: 200),
            iconsStackView.topAnchor.constraint(equalTo: photoPublisher.bottomAnchor, constant: 15),
            iconsStackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            iconsStackView.widthAnchor.constraint(equalToConstant: 100),
            iconsStackView.heightAnchor.constraint(equalToConstant: 30),
            favoriteIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            favoriteIcon.topAnchor.constraint(equalTo: photoPublisher.bottomAnchor, constant: 15),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 30),
            descriptionPublisher.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionPublisher.topAnchor.constraint(equalTo: iconsStackView.bottomAnchor, constant: 15),
            datePublisher.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            datePublisher.topAnchor.constraint(equalTo: descriptionPublisher.bottomAnchor, constant: 10),

        ])
    }
    
    func configure(with publisher: Publisher){
        photoPublisher.image = publisher.image
        datePublisher.text = publisher.date
        descriptionPublisher.text = publisher.description
    }
}
