import UIKit
protocol PublicationCollectionViewCellDelegate: AnyObject {
    func deleteItem(photo: Photo) async
}
class PublicationCollectionViewCell: UICollectionViewCell {
    weak var delegate: PublicationCollectionViewCellDelegate?
    var alert: ((_ alertController: UIAlertController) -> Void)?
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var accountNameLabel: UILabel = UILabel()
    lazy var funcButton: UIButton = UIButton()
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    lazy var likeButton: UIButton = UIButton()
    lazy var messageButton: UIButton = UIButton()
    lazy var shareButton: UIButton = UIButton()
    lazy var subStackview: UIStackView = UIStackView()
    lazy var bookmarkButton: UIButton = UIButton()
    lazy var commentLabel: UILabel = UILabel()
    lazy var commentAccountNameLabel: UILabel = UILabel()
    lazy var dateLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp() {
        setUpAvatarImageView()
        setUpAccountNameLabel()
        setUpImageView()
        setUpSubStackView()
        setUpFuncButton()
        setUpBookmarkButton()
        setUpCommentAccountNameLabel()
        setUpCommentLabel()
        setUpDateLabel()

    }
    /// Label
    private func setUpAccountNameLabel() {
        contentView.addSubview(accountNameLabel)
        accountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        accountNameLabel.textColor = .white
        NSLayoutConstraint.activate([
            accountNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            accountNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            accountNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            accountNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
    }
    private func setUpCommentAccountNameLabel() {
        contentView.addSubview(commentAccountNameLabel)
        commentAccountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        commentAccountNameLabel.textColor = .white
        commentAccountNameLabel.font = UIFont(name: "boldSystemFont", size: 12)
        NSLayoutConstraint.activate([
            commentAccountNameLabel.topAnchor.constraint(equalTo: subStackview.bottomAnchor),
            commentAccountNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            commentAccountNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            commentAccountNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
    }
    private func setUpCommentLabel() {
        contentView.addSubview(commentLabel)
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.textColor = .white
        commentLabel.font = UIFont(name: "boldSystemFont", size: 8)
        NSLayoutConstraint.activate([
            commentLabel.topAnchor.constraint(equalTo: subStackview.bottomAnchor),
            commentLabel.leadingAnchor.constraint(equalTo: commentAccountNameLabel.trailingAnchor, constant: 6),
            commentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            commentLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1)
        ])
    }
    private func setUpDateLabel() {
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "6дн. назад"
        dateLabel.textColor = .systemGray
        dateLabel.font = UIFont(name: "systemFont", size: 16)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: commentAccountNameLabel.bottomAnchor, constant: -6),
            dateLabel.leadingAnchor.constraint(equalTo: commentAccountNameLabel.leadingAnchor, constant: 5),
            dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            dateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.06)
        ])
    }
    /// Image
    private func setUpAvatarImageView() {
        contentView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        avatarImageView.layer.borderWidth = 1.0
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.cornerRadius = 18
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.08)
        ])
    }
    private func setUpImageView() {
        contentView.addSubview(mainImageView)
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            mainImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.64)
        ])
    }
    /// StackView
    private func setUpSubStackView() {
        setUpLikeButton()
        setUpMessageButton()
        setUpShareButton()
        subStackview.addArrangedSubview(likeButton)
        subStackview.addArrangedSubview(messageButton)
        subStackview.addArrangedSubview(shareButton)
        contentView.addSubview(subStackview)
        subStackview.translatesAutoresizingMaskIntoConstraints = false
        subStackview.axis = .horizontal
        subStackview.alignment = .center
        subStackview.distribution = .fillEqually
        subStackview.spacing = 6
        NSLayoutConstraint.activate([
            subStackview.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 8),
            subStackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subStackview.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.265),
            subStackview.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
    }
    /// Button
    private func setUpLikeButton() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func setUpMessageButton() {
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.setImage(.message, for: .normal)
    }
    private func setUpShareButton() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.setImage(.share, for: .normal)
    }
    private func setUpFuncButton() {
        contentView.addSubview(funcButton)
        funcButton.translatesAutoresizingMaskIntoConstraints = false
        funcButton.setImage(.functionButton, for: .normal)
        NSLayoutConstraint.activate([
            funcButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            funcButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            funcButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1),
            funcButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.075)
        ])
    }
    private func  setUpBookmarkButton() {
        contentView.addSubview(bookmarkButton)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.setImage(.bookmark, for: .normal)
        NSLayoutConstraint.activate([
            bookmarkButton.topAnchor.constraint(equalTo: subStackview.topAnchor, constant: 5),
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bookmarkButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.06),
            bookmarkButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.05)
        ])
    }
    func configure(with photo: Photo) {
        mainImageView.image = photo.image
        accountNameLabel.text = photo.author
        avatarImageView.image = photo.avatar
        commentAccountNameLabel.text =  photo.author
        commentLabel.text = photo.comment
        likeButton.setImage(.unlike, for: .normal)
        deleteAlert(photo: photo)
        addTargetForButton(photo: photo)
    }
    func deleteAlert(photo: Photo) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            Task {
                await self?.delegate?.deleteItem(photo: photo)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        funcButton.addAction(UIAction(handler: { [weak self] _ in
            self?.alert?(alertController)
        }), for: .touchUpInside)
    }
    func addTargetForButton(photo: Photo) {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    @objc func likeButtonTapped() {
        if likeButton.currentImage == .unlike {
            UIView.transition(with: likeButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                  self.likeButton.setImage(UIImage(named: "like"), for: .normal)
              })
        } else {
            UIView.transition(with: likeButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                  self.likeButton.setImage(UIImage(named: "unlike"), for: .normal)
              })
        }
    }
}
