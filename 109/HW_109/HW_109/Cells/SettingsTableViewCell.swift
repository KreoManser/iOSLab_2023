import UIKit
class SettingsTableViewCell: UITableViewCell {
    lazy var icon: UIImageView = UIImageView()
    lazy var title: UILabel = UILabel()
    lazy var arrow: UILabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        backgroundColor = .black
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp() {
        setUpIcon()
        setUpTitle()
        setUpArrow()
    }
    func setUpIcon() {
        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = .bookmark
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            icon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.08),
            icon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }
    func setUpTitle() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "messages"
        title.font = UIFont(name: "boldSystemFont", size: 8)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            title.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            title.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6)
        ])
    }
    func setUpArrow() {
        contentView.addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.textColor = .white
        arrow.text = ">"
        arrow.font = UIFont(name: "systemFont", size: 26)
        NSLayoutConstraint.activate([
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 10),
            arrow.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.07),
            arrow.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
    }
    func configure(title: String, icon: UIImage, color: UIColor, section: Int) {
        self.icon.image = icon
        self.title.text = title
        self.title.textColor = color
    }
}
extension SettingsTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
