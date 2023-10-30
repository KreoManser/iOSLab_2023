import Foundation
import UIKit

class PostDetailViewController: UIViewController {

    private let post: Post

    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = "yazgul"
        return label
    }()

//    var dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    let dateString = dateFormatter.string(from: post.date)

    lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = post.caption
        return label
    }()

    lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = post.image
        return image
    }()

    lazy var postButton: UIButton = {

        let action = UIAction { _ in
            //            доделаю
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("...", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        return button
    }()

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(usernameLabel)
        //        view.addSubview(dateString)
        view.addSubview(captionLabel)
        view.addSubview(avatarImageView)
        view.addSubview(postImageView)
        view.addSubview(postButton)

        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            postImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50),

            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            avatarImageView.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(equalToConstant: 10.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 10.0),

            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            usernameLabel.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: 5),
            usernameLabel.heightAnchor.constraint(equalToConstant: 10.0),
            usernameLabel.widthAnchor.constraint(equalToConstant: 20.0),

            postButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            postButton.heightAnchor.constraint(equalToConstant: 10.0),
            postButton.bottomAnchor.constraint(equalTo: postImageView.topAnchor, constant: 5),
            postButton.widthAnchor.constraint(equalToConstant: 15.0),

            captionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 5),
            captionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            captionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            captionLabel.heightAnchor.constraint(equalToConstant: 10.0)

        ])
    }
}
