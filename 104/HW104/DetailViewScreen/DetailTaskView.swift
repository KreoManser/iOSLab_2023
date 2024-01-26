//
//  DetailTaskView.swift
//  HW104
//
//  Created by Ильмир Шарафутдинов on 24.01.2024.
//

import UIKit

class DetailTaskView: UIView {
    
    let fieldTopAncorConstant = 100
    let fieldBottomAncorConstant = 600
    let priorityLabelTopAncor = 20
    let priorityLabelLeadingAndTrailingAncor = 15
    let buttonLeadingAndTrailingAncor = 30
    let buttonToChangeBottomAncor = -50
    
    var detailViewController: DetailViewController?
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker ()
        datePicker.datePickerMode = .date
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    
    lazy var toolbarDate = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        return toolbar
    }()
    
    lazy var fieldForModification = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .systemGroupedBackground
        field.textColor = .black
        field.placeholder = "Введите текст"
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.font = UIFont.systemFont(ofSize: CGFloat(15))

        return field
    }()
    
    lazy var dateField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .systemGroupedBackground
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.font = UIFont.systemFont(ofSize: CGFloat(15))

        return field
    }()
    
    lazy var headlineLabel = {
        let label = UILabel()
        label.text = "Детальный экран"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        label.text = "Выберите название"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priorityLabel = {
        let label = UILabel()
        label.text = "Выберите приоритет"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel = {
        let label = UILabel()
        label.text = "Выберите время дедлайна"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var highPriorityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var middlePriorityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var lowPriorityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var buttonToChange: UIButton = {
        let action = UIAction { _ in
            self.buttonToChangeAction()
        }
        let button = UIButton(configuration: .filled(), primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .lightGray
        button.setTitle("Продолжить", for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayouts()
        setupConstraints()
        setupDate()
        
        highPriorityButton.addTarget(self, action: #selector(highPriorityButtonTapped), for: .touchUpInside)
        middlePriorityButton.addTarget(self, action: #selector(middlePriorityButtonTapped), for: .touchUpInside)
        lowPriorityButton.addTarget(self, action: #selector(lowPriorityButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(fieldForModification)
        addSubview(priorityLabel)
        addSubview(highPriorityButton)
        addSubview(middlePriorityButton)
        addSubview(lowPriorityButton)
        addSubview(buttonToChange)
        addSubview(dateLabel)
        addSubview(dateField)
        addSubview(titleLabel)
        addSubview(headlineLabel)
    }
    
    private func setupLayouts() {
        backgroundColor = .white
        
        highPriorityButton.setImage(UIImage(named: "gray_flag"), for: .normal)
        highPriorityButton.setImage(UIImage(named: "red_flag"), for: .selected)
        
        middlePriorityButton.setImage(UIImage(named: "gray_flag"), for: .normal)
        middlePriorityButton.setImage(UIImage(named: "orange_flag"), for: .selected)
        
        lowPriorityButton.setImage(UIImage(named: "gray_flag"), for: .normal)
        lowPriorityButton.setImage(UIImage(named: "yellow_flag"), for: .selected)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headlineLabel.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(priorityLabelLeadingAndTrailingAncor)),
            headlineLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: -CGFloat(buttonToChangeBottomAncor)),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            
            fieldForModification.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: CGFloat(priorityLabelLeadingAndTrailingAncor)),
            fieldForModification.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            fieldForModification.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(buttonLeadingAndTrailingAncor)),
            
            priorityLabel.topAnchor.constraint(equalTo: fieldForModification.bottomAnchor, constant: -CGFloat(buttonToChangeBottomAncor)),
            priorityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            priorityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(priorityLabelLeadingAndTrailingAncor)),
            
            highPriorityButton.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: CGFloat(priorityLabelTopAncor)),
            highPriorityButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            
            middlePriorityButton.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: CGFloat(priorityLabelTopAncor)),
            middlePriorityButton.leadingAnchor.constraint(equalTo: highPriorityButton.trailingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            
            lowPriorityButton.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: CGFloat(priorityLabelTopAncor)),
            lowPriorityButton.leadingAnchor.constraint(equalTo: middlePriorityButton.trailingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            
            dateLabel.topAnchor.constraint(equalTo: lowPriorityButton.bottomAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(priorityLabelLeadingAndTrailingAncor)),
            
            dateField.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: CGFloat(priorityLabelLeadingAndTrailingAncor)),
            dateField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            dateField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(buttonLeadingAndTrailingAncor)),
            
            buttonToChange.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat(buttonToChangeBottomAncor)),
            buttonToChange.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(buttonLeadingAndTrailingAncor)),
            buttonToChange.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CGFloat(buttonLeadingAndTrailingAncor))
        ])
    }
    
    func setupDate() {
        dateField.inputView = datePicker
        datePicker.datePickerMode = .date
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let weekAgo = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        addGestureRecognizer(tapGesture)
        
        toolbarDate.setItems([flexSpace, doneButton], animated: true)
        datePicker.addTarget(self, action: #selector (dateChanged), for: .valueChanged)
        datePicker.minimumDate = weekAgo
        datePicker.date = weekAgo!
    }
    
    func buttonToChangeAction() {
        if self.fieldForModification.text?.replacingOccurrences(of: " ", with: "") != "" {
            var priority = TaskPriority.none
            if highPriorityButton.isSelected {
                priority = .high
            } else if middlePriorityButton.isSelected {
                priority = TaskPriority.middle
            } else if lowPriorityButton.isSelected {
                priority = TaskPriority.low
            }
            if self.detailViewController?.task == nil {
                let newTask = Task(
                    title: self.fieldForModification.text ?? "" ,
                    isTaskDone: false,
                    priority: priority,
                    dateOfCreating: .now,
                    dateOfExpiration: datePicker.date
                )
                self.detailViewController?.addNewTask(task: newTask)
            } else {
                self.detailViewController?.task?.priority = priority
                self.detailViewController?.task?.dateOfExpiration = datePicker.date
                self.detailViewController?.updateTask()
            }
            self.detailViewController?.dismiss(animated: true)
        }
    }
    
    func configureDate(by task: Task?) {
        datePicker.date = task?.dateOfExpiration ?? .now
        getDateFromPicker()
    }
    
    func configurePriority(by task: Task?) {
        switch task?.priority {
        case .high:
            highPriorityButton.isSelected = true
            middlePriorityButton.isSelected = false
            lowPriorityButton.isSelected = false
            break
        case .middle:
            highPriorityButton.isSelected = false
            middlePriorityButton.isSelected = true
            lowPriorityButton.isSelected = false
            break
        case .low:
            highPriorityButton.isSelected = false
            middlePriorityButton.isSelected = false
            lowPriorityButton.isSelected = true
            break
        default:
            highPriorityButton.isSelected = false
            middlePriorityButton.isSelected = false
            lowPriorityButton.isSelected = false
            break
        }
    }
    
    @objc func doneAction() {
        endEditing(true)
    }
    
    @objc func dateChanged() {
        getDateFromPicker()
    }
    
    @objc func tapGestureDone() {
        endEditing(true)
    }
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateField.text = formatter.string(from: datePicker.date)
    }
    
    @objc func highPriorityButtonTapped() {
        highPriorityButton.isSelected.toggle()
        if highPriorityButton.isSelected == true {
            middlePriorityButton.isSelected = false
            lowPriorityButton.isSelected = false
        }
    }
    
    @objc func middlePriorityButtonTapped() {
        middlePriorityButton.isSelected.toggle()
        if middlePriorityButton.isSelected == true {
            highPriorityButton.isSelected = false
            lowPriorityButton.isSelected = false
        }
    }
    
    @objc func lowPriorityButtonTapped() {
        lowPriorityButton.isSelected.toggle()
        if lowPriorityButton.isSelected == true {
            highPriorityButton.isSelected = false
            middlePriorityButton.isSelected = false
        }
    }
    
}

