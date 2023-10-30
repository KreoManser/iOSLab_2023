import UIKit
 class ViewController: UIViewController {
     var publishers = Manager.publishers
     lazy var buttonForRefactorProfile: UIButton = {
         var action = UIAction { _ in
         }
         let button = UIButton(type: .custom)
         let buttonImage = UIImage(named: "threePoints")
         button.setImage(buttonImage, for: .normal)
         button.addAction(action , for: .touchUpInside)
         return button
     }()
     lazy var avatarImage: UIImageView = {
         let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         return image
     }()
     lazy var textPublication: UILabel = {
         let text = UILabel()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.textColor = .white
         text.font = UIFont.systemFont(ofSize: 12)
         text.text = "Publication"
         return text
     }()
     lazy var numberPublication: UILabel = {
         let text = UILabel()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.textColor = .white
         text.font = UIFont.boldSystemFont(ofSize: 17)
         text.text = "3"
         return text
     }()
     lazy var textSubscribers: UILabel = {
         let text = UILabel()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.textColor = .white
         text.font = UIFont.systemFont(ofSize: 12)
         text.text = "Subscribers"
         return text
     }()
     lazy var numberSubscribers: UILabel = {
         let text = UILabel()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.textColor = .white
         text.font = UIFont.boldSystemFont(ofSize: 17)
         text.text = "1000000"
         return text
     }()
     lazy var textSubscriptions: UILabel = {
         let text = UILabel()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.textColor = .white
         text.font = UIFont.systemFont(ofSize: 12)
         text.text = "Subscriptions"
         return text
     }()
     lazy var numberSubscriptions: UILabel = {
         let text = UILabel()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.textColor = .white
         text.font = UIFont.boldSystemFont(ofSize: 17)
         text.text = "200"
         return text
     }()
     lazy var descriptionCanal: UILabel = {
         let text = UILabel()
         text.translatesAutoresizingMaskIntoConstraints = false
         text.font = UIFont.systemFont(ofSize: 15)
         text.textColor = .white
         text.text = "Мой блог"
         return text
     }()
     lazy var gridCollectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 10
         layout.itemSize = CGSize(width: 110, height: 100)

         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.backgroundColor = .clear
         collectionView.register(GridCell.self, forCellWithReuseIdentifier: GridCell.reuseIdentifier)
         collectionView.dataSource = self
         collectionView.delegate = self
         return collectionView
     }()
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         view.backgroundColor = .black
         
         if let image = UIImage(named: "photo1"){
             avatarImage.image = image
         }
         avatarImage.layer.cornerRadius = 40
         avatarImage.clipsToBounds = true
         
         view.addSubview(avatarImage)
         view.addSubview(descriptionCanal)
         
         view.addSubview(gridCollectionView)
         
         setupLayout()
         setupNavigationBar()
     }
     func setupLayout() {
         let mainStacklView1 = createVerticalStackView([textPublication, numberPublication])
         let mainStacklView2 = createVerticalStackView([textSubscribers, numberSubscribers])
         let mainStacklView3 = createVerticalStackView([textSubscriptions, numberSubscriptions])
         view.addSubview(mainStacklView1)
         view.addSubview(mainStacklView2)
         view.addSubview(mainStacklView3)
             NSLayoutConstraint.activate([
                 avatarImage.widthAnchor.constraint(equalToConstant: 80),
                 avatarImage.heightAnchor.constraint(equalToConstant: 80),
                 avatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                 avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                 mainStacklView1.trailingAnchor.constraint(equalTo: mainStacklView2.leadingAnchor, constant: -10),
                 mainStacklView1.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                 mainStacklView1.widthAnchor.constraint(equalToConstant: 80),
                 mainStacklView1.heightAnchor.constraint(equalToConstant: 40),
                 mainStacklView2.trailingAnchor.constraint(equalTo: mainStacklView3.leadingAnchor, constant: -10),
                 mainStacklView2.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                 mainStacklView2.widthAnchor.constraint(equalToConstant: 80),
                 mainStacklView2.heightAnchor.constraint(equalToConstant: 40),
                 mainStacklView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                 mainStacklView3.topAnchor.constraint(equalTo: avatarImage.centerYAnchor, constant: -15),
                 mainStacklView3.widthAnchor.constraint(equalToConstant: 80),
                 mainStacklView3.heightAnchor.constraint(equalToConstant: 40),
                 descriptionCanal.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 15),
                 descriptionCanal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                 descriptionCanal.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 gridCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                 gridCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                 gridCollectionView.topAnchor.constraint(equalTo: descriptionCanal.bottomAnchor, constant: 15),
                 gridCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
         ])
     }
     func createVerticalStackView(_ views: [UIView]) -> UIStackView {
         let stackView = UIStackView(arrangedSubviews: views)
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .vertical
         stackView.alignment = .center
         stackView.distribution = .fillEqually
         stackView.spacing = 5
         return stackView
     }
     func setupNavigationBar() {
         let customBarButtonItem = UIBarButtonItem(customView: buttonForRefactorProfile )
         navigationItem.rightBarButtonItem = customBarButtonItem
         navigationItem.title = "Cat_Boss"
         navigationItem.titleView?.tintColor = .white
         navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
     }
 }
 extension ViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return Manager.publishers.count
     }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifier, for: indexPath) as? GridCell {
             let publisher = Manager.publishers[indexPath.row]
             cell.configure(with: publisher)
             
             cell.configure(with: publisher)
            
     return cell
         } else {
             // Handle the case where the cast failed
             return UICollectionViewCell() // Or any other appropriate action
         }
     }
 }

 extension ViewController: UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let publisherViewController = PublisherViewController()
         publisherViewController.selectedIndexPath = indexPath
         present(publisherViewController, animated: true, completion: nil)
     }
 }

 class GridCell: UICollectionViewCell {
     var imagePhoto: UIImage?
     lazy var image: UIImageView = {
         let image = UIImageView()
         image.translatesAutoresizingMaskIntoConstraints = false
         return image
     }()
     
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         contentView.addSubview(image)
         
         NSLayoutConstraint.activate([
             image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
             image.topAnchor.constraint(equalTo: contentView.topAnchor),
             image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
         ])
     }
     func configure(with publisher: Publisher) {
         image.image = publisher.image
     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 }
 extension GridCell {
     static var reuseIdentifier: String {
         return String(describing: self)
     }
 }

