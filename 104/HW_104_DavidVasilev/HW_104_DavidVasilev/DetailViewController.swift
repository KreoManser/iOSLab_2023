import UIKit
protocol DetailControllerDelegate : AnyObject{
    func dataUpdate(for task: Task) 
}

class DetailViewController: UIViewController  {
    lazy var titleTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = .black
        text.font = UIFont.boldSystemFont(ofSize: 20)
        return text
    }()
    lazy var saveButton: UIButton = {
        let action = UIAction{ _ in
            let updateTask = Task(
                id: self.currentTask.id,
                title: self.titleTextField.text ?? "",
                shortDescription: self.shortDescriptionTextView.text,
                fullDescription: self.fullDescriptionTextView.text)
            self.delegate?.dataUpdate(for: updateTask)
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemMint
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Save", for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "short description"
        return label
    }()
    lazy var shortDescriptionTextView: UITextView = {
        let textView =  UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemTeal.withAlphaComponent(0.9)
        textView.textColor = .black
        textView.tintColor = .white
        textView.returnKeyType = .default
        textView.textAlignment = .left
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 24)
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 10
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.9
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.shadowRadius = 10
        textView.layer.masksToBounds = false
        return textView
    }()
    lazy var fullDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "full description"
        return label
    }()
    lazy var fullDescriptionTextView: UITextView = {
        let textView =  UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .systemTeal.withAlphaComponent(0.9)
        textView.textColor = .black
        textView.tintColor = .white
        textView.returnKeyType = .default
        textView.textAlignment = .left
        textView.isScrollEnabled = true
        textView.font = UIFont.systemFont(ofSize: 24)
        textView.autocorrectionType = .no
        textView.layer.cornerRadius = 10
        textView.layer.shadowColor = UIColor.black.cgColor
        textView.layer.shadowOpacity = 0.9
        textView.layer.shadowOffset = CGSize(width: 0, height: 2)
        textView.layer.shadowRadius = 10
        textView.layer.masksToBounds = false
        return textView
    }()
    private weak var delegate : DetailControllerDelegate?
    private var currentTask: Task!
    init(with task: Task, delegate: DetailControllerDelegate ){
        super.init(nibName: nil, bundle: nil)
        self.currentTask = task
        self.delegate = delegate
        titleTextField.text = currentTask.title
        shortDescriptionTextView.text = currentTask.shortDescription
        fullDescriptionTextView.text = currentTask.fullDescription
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleTextField)
        view.addSubview(fullDescriptionTextView)
        view.addSubview(saveButton)
        view.addSubview(shortDescriptionTextView)
        view.addSubview(shortDescriptionLabel)
        view.addSubview(fullDescriptionLabel)
        setupLayout()
        view.backgroundColor = .systemMint
    }
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leftAnchor.constraint(equalTo: shortDescriptionTextView.leftAnchor),
            
            saveButton.bottomAnchor.constraint(equalTo:  titleTextField.bottomAnchor),
            saveButton.rightAnchor.constraint(equalTo: shortDescriptionTextView.rightAnchor),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            saveButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            
            shortDescriptionLabel.bottomAnchor.constraint(equalTo: shortDescriptionTextView.topAnchor, constant: -4),
            shortDescriptionLabel.leftAnchor.constraint(equalTo: shortDescriptionTextView.leftAnchor),
            
            shortDescriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 50),
            shortDescriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            shortDescriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            shortDescriptionTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            fullDescriptionLabel.bottomAnchor.constraint(equalTo: fullDescriptionTextView.topAnchor, constant: -4),
            fullDescriptionLabel.leftAnchor.constraint(equalTo: fullDescriptionTextView.leftAnchor),
            
            fullDescriptionTextView.topAnchor.constraint(equalTo: shortDescriptionTextView.bottomAnchor, constant: 36),
            fullDescriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fullDescriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            fullDescriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
}
