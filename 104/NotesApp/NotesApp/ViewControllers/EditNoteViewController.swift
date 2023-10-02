//
//  EditNoteViewController.swift
//  NotesApp
//
//  Created by Mac on 2023-10-01.
//

import UIKit

protocol EditNoteDelegate {
    func changeNote(with newNote: Note)
}

class EditNoteViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var nameTextField: UITextField = {
        let name = UITextField()
        name.text = "Write your note"
        name.backgroundColor = .lightGray
        name.layer.cornerRadius = 5
        name.tag = 1
        name.delegate = self
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var iconNameTextField: UITextField = {
        let iconName = UITextField()
        iconName.text = "Write name of icon, for example 'icon'"
        iconName.backgroundColor = .lightGray
        iconName.layer.cornerRadius = 5
        iconName.tag = 2
        iconName.delegate = self
        iconName.translatesAutoresizingMaskIntoConstraints = false
        return iconName
    }()
    
    private lazy var describtionTextField: UITextView = {
        let describtion = UITextView()
        describtion.text = "Write describtion of note"
        describtion.backgroundColor = .lightGray
        describtion.layer.cornerRadius = 5
        describtion.delegate = self
        describtion.translatesAutoresizingMaskIntoConstraints = false
        describtion.isScrollEnabled = false
        describtion.isEditable = true
        return describtion
    }()
    
    private lazy var writePriorityLabel: UILabel = {
        let priority = UILabel()
        priority.text = "Choose Priority Level"
        priority.translatesAutoresizingMaskIntoConstraints = false
        return priority
    }()
    
    private lazy var prioritySegmentedControl: UISegmentedControl = {
        let priorities = UISegmentedControl(items: ["1", "2", "3"])
        priorities.translatesAutoresizingMaskIntoConstraints = false
        
        return priorities
    }()
    
    private lazy var endDate: Date = createNextDate()
    private lazy var isDone: Bool = false
    
    private lazy var editedNote: Note = createNoteForChange()
    
    var delegate: EditNoteDelegate?
    
    // MARK: - Init
    init(with note: Note) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = "Edit Note"
        self.nameTextField.text = note.title
        self.describtionTextField.text = note.describtion
        self.iconNameTextField.text = note.iconName
        self.writePriorityLabel.text = "Priotity level"
        self.endDate = note.endDate
        self.isDone = note.isDone
        
        switch note.levelOfPriority.rawValue {
        case 1:
            self.prioritySegmentedControl.selectedSegmentIndex = 0
        case 2:
            self.prioritySegmentedControl.selectedSegmentIndex = 1
        case 3:
            self.prioritySegmentedControl.selectedSegmentIndex = 2
        default:
            self.prioritySegmentedControl.selectedSegmentIndex = 0
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        setupNavigationBar()
        prioritySegmentedControl.addTarget(self, action: #selector(prioritySegmentedControlChanged(_:)), for: .valueChanged)
    }
}

// MARK: - Constraints
extension EditNoteViewController {
    private func setupLayouts() {
        view.addSubview(nameTextField)
        view.addSubview(describtionTextField)
        view.addSubview(iconNameTextField)
        view.addSubview(writePriorityLabel)
        view.addSubview(prioritySegmentedControl)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 2),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -2),
            nameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            iconNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 6),
            iconNameTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            iconNameTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            iconNameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            describtionTextField.topAnchor.constraint(equalTo: iconNameTextField.bottomAnchor, constant: 6),
            describtionTextField.leadingAnchor.constraint(equalTo: iconNameTextField.leadingAnchor),
            describtionTextField.trailingAnchor.constraint(equalTo: iconNameTextField.trailingAnchor),
            
            writePriorityLabel.topAnchor.constraint(equalTo: describtionTextField.bottomAnchor, constant: 6),
            writePriorityLabel.leadingAnchor.constraint(equalTo: describtionTextField.leadingAnchor),
            
            prioritySegmentedControl.topAnchor.constraint(equalTo: writePriorityLabel.bottomAnchor, constant: 6),
            prioritySegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: - Navigation Bar
extension EditNoteViewController {
    private func setupNavigationBar() {
        let addNoteAction = UIAction { _ in
            self.delegate?.changeNote(with: self.editedNote)
        }
        navigationItem.title = "Add Note"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: addNoteAction, menu: nil)
    }
}

// MARK: - View Items Delegate
extension EditNoteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            editedNote.title = textField.text ?? editedNote.title
        case 2:
            editedNote.iconName = textField.text?.lowercased() ?? editedNote.iconName
        default:
            print("Something wrong")
            break
        }
    }
}

extension EditNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        editedNote.describtion = textView.text
    }
}

// MARK: - ObjC
extension EditNoteViewController {
    @objc func prioritySegmentedControlChanged(_ sender: UISegmentedControl) {
        editedNote.levelOfPriority = setLevelOfPriority(sender)
    }
}

// MARK: - Support things
extension EditNoteViewController {
    private func createNoteForChange() -> Note {
        Note(title: self.nameTextField.text ?? "", describtion: self.describtionTextField.text, iconName: iconNameTextField.text ?? "", endDate: endDate, levelOfPriority: setLevelOfPriority(self.prioritySegmentedControl), isDone: self.isDone)
    }
    
    private func createNextDate() -> Date {
        let currentDate = Date()
        let oneDay: TimeInterval = 60 * 60 * 24
        let nextDay = currentDate.addingTimeInterval(oneDay)
        
        return nextDay
    }
    
    private func setLevelOfPriority(_ segmentedControl: UISegmentedControl) -> LevelOfPrority {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return LevelOfPrority(rawValue: 1)!
        case 1:
            return LevelOfPrority(rawValue: 2)!
        case 2:
            return LevelOfPrority(rawValue: 3)!
        default:
            return LevelOfPrority(rawValue: 1)!
        }
    }
}
