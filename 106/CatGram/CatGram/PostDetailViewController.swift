import Foundation
import UIKit

protocol PostDetailViewControllerDelegate: AnyObject {
    func reloadArrayAfterDeleting(_ postDetailVC: PostDetailViewController, didDeletePost post: Post)
}

class PostDetailViewController: UIViewController {

    private let post: Post
    private let dataManager = DataManager()
    var dateFormatter = DateFormatter()
    let user = User()
    weak var delegate: PostDetailViewControllerDelegate?

    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = user.profileImage
        image.layer.cornerRadius = 50 / 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = user.username
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    lazy var postButton: UIButton = {

        let action = UIAction { [weak self] _ in
            self?.showPostOptions()
        }
        let button = UIButton(configuration: .plain(), primaryAction: action)
        button.setTitle("...", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = post.image
        return image
    }()
    lazy var countOfLikesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(post.countOfLikes) + " likes"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = post.caption
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = dateFormatter.string(from: post.date)
        return label
    }()

    func showPostOptions() {
//        print(dataManager.syncGetPosts().count)
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            let selectedPost = self.post
            self.dataManager.asyncDelete(post: selectedPost) {success in
                if success {
                    self.delegate?.reloadArrayAfterDeleting(self, didDeletePost: selectedPost)
                    let deletedAlert = UIAlertController(title: "Удалено", message: "Пост успешно удален", preferredStyle: .alert)
//                    print(self.dataManager.syncGetPosts().count)
                    deletedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(deletedAlert, animated: true, completion: nil)
                } else {
                    let errorAlert = UIAlertController(title: "Ошибка", message: "Не удалось удалить пост", preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)

        dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(usernameLabel)
        view.addSubview(captionLabel)
        view.addSubview(avatarImageView)
        view.addSubview(postImageView)
        view.addSubview(postButton)
        view.addSubview(countOfLikesLabel)
        view.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            postImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            postImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),

            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50.0),

            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20.0),
            usernameLabel.widthAnchor.constraint(equalToConstant: 30.0),

            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            postButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 40.0),
            postButton.widthAnchor.constraint(equalToConstant: 50.0),

            countOfLikesLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
            countOfLikesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            countOfLikesLabel.heightAnchor.constraint(equalToConstant: 30.0),
            countOfLikesLabel.widthAnchor.constraint(equalToConstant: 60.0),

            captionLabel.topAnchor.constraint(equalTo: countOfLikesLabel.bottomAnchor, constant: 5),
            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            captionLabel.heightAnchor.constraint(equalToConstant: 30.0),

            dateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dateLabel.heightAnchor.constraint(equalToConstant: 30.0),
            dateLabel.widthAnchor.constraint(equalToConstant: 80.0)

        ])
    }
}
