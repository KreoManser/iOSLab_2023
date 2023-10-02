import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        return text
    }()
    
    lazy var descriptionLabel: UILabel = {
        let text = UILabel ()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        text.textColor = .gray
        return text
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
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(task: Task) {
        titleLabel.text = String(task.title.prefix(10))
        descriptionLabel.text = String(task.description.prefix(30))
    }
    
    func setupLayout() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

        ])
    }
}
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
