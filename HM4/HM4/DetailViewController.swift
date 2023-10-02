import UIKit

protocol DetailControllerDelegate: AnyObject {
    func dataUpdated(for user: User)
}

class DetailViewController: UIViewController {
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.boldSystemFont(ofSize: 28)
        textField.borderStyle = .roundedRect
        textField.isHidden = true
        return textField
    }()

    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.isHidden = true
        return textField
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.numberOfLines = 0

        return label
    }()
    
    lazy var saveButton: UIButton = {
       
        let action = UIAction { [self] _ in
            let updatedName = self.nameTextField.text ?? ""
            let updatedLastName = lastNameTextField.text ?? ""
            
            let updatedUser = User(id: currentUser.id,
                                   name: updatedName,
                                   lastName: updatedLastName)
        
            delegate?.dataUpdated(for: updatedUser)
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    lazy var cancelButton: UIButton = {
       
        let action = UIAction { [self] _ in
            self.navigationController?.popViewController(animated: true)
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.setTitle("Отменить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    private weak var delegate: DetailControllerDelegate?
    private var currentUser: User!
    
    init(with user: User, delegate: DetailControllerDelegate?) {
        super.init(nibName: nil, bundle: nil)
    
        self.currentUser = user
        self.delegate = delegate
        
        label.text = currentUser.name + "\n" + currentUser.lastName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(editButtonTapped))
        
        navigationItem.rightBarButtonItem = editButton
            
        let attributedText = NSMutableAttributedString(string: currentUser.name, attributes: [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)])
        
        attributedText.append(NSAttributedString(string: "\n" + currentUser.lastName, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
            
        nameTextField.text = currentUser.name
        lastNameTextField.text = currentUser.lastName

        view.addSubview(label)
        view.addSubview(nameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            lastNameTextField.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            lastNameTextField.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
    
    @objc func editButtonTapped() {
        label.isHidden = !label.isHidden
        nameTextField.isHidden = !nameTextField.isHidden
        lastNameTextField.isHidden = !lastNameTextField.isHidden
        saveButton.isHidden = !saveButton.isHidden
        cancelButton.isHidden = !cancelButton.isHidden
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
    }

}
