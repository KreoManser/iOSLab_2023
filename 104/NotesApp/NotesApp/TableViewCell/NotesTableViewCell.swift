//
//  NotesTableViewCell.swift
//  NotesApp
//
//  Created by Mac on 2023-10-01.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    // MARK: - Declaration objects
    lazy var noteImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var noteTitleLable: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var noteDescriptionLable: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 10)
        description.numberOfLines = 0
        description.lineBreakMode = .byWordWrapping
        return description
    }()
    
    lazy var noteLevelOfPriorityLable: UILabel = {
        let level = UILabel()
        level.translatesAutoresizingMaskIntoConstraints = false
        level.font = UIFont.systemFont(ofSize: 14)
        return level
    }()
    
    lazy var noteEndDateLable: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = UIFont.systemFont(ofSize: 10)
        return date
    }()
    
    private var isDone = false
    lazy var isDoneNoteButton: UIButton = {
        let button = UIButton(type: .close)
        let changeStatusAction = UIAction { _ in
            if self.isDone {
                button.setImage(UIImage(named: "unfilled"), for: .normal)
                self.isDone = false
            } else {
                button.setImage(UIImage(named: "filled"), for: .normal)
                self.isDone = true
            }
        }
        button.addAction(changeStatusAction, for: .touchUpInside)
        button.setImage(UIImage(named: "unfilled"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints
extension NotesTableViewCell {
    private func setupLayouts() {
        contentView.addSubview(noteImage)
        contentView.addSubview(noteTitleLable)
        contentView.addSubview(noteDescriptionLable)
        contentView.addSubview(noteLevelOfPriorityLable)
        contentView.addSubview(noteEndDateLable)
        contentView.addSubview(isDoneNoteButton)
        
        NSLayoutConstraint.activate([
            noteImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            noteImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            noteImage.widthAnchor.constraint(equalToConstant: 40),
            noteImage.heightAnchor.constraint(equalToConstant: 40),
            
            noteTitleLable.leadingAnchor.constraint(equalTo: noteImage.trailingAnchor, constant: 10),
            noteTitleLable.topAnchor.constraint(equalTo: noteImage.topAnchor),
            
            noteDescriptionLable.leadingAnchor.constraint(equalTo: noteTitleLable.leadingAnchor),
            noteDescriptionLable.topAnchor.constraint(equalTo: noteTitleLable.bottomAnchor, constant: 2),
            noteDescriptionLable.widthAnchor.constraint(equalToConstant: 200),
            noteDescriptionLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            isDoneNoteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            isDoneNoteButton.centerYAnchor.constraint(equalTo: noteImage.centerYAnchor),
            isDoneNoteButton.heightAnchor.constraint(equalToConstant: 30),
            isDoneNoteButton.widthAnchor.constraint(equalToConstant: 30),
            
            noteLevelOfPriorityLable.topAnchor.constraint(equalTo: isDoneNoteButton.topAnchor),
            noteLevelOfPriorityLable.trailingAnchor.constraint(equalTo: isDoneNoteButton.leadingAnchor, constant: -2),
            
            noteEndDateLable.bottomAnchor.constraint(equalTo: isDoneNoteButton.bottomAnchor),
            noteEndDateLable.trailingAnchor.constraint(equalTo: noteLevelOfPriorityLable.trailingAnchor)
            
        ])
    }
}

// MARK: - ViewCell settings
extension NotesTableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func configureCell(with note: Note) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy HH:mm"
        
        noteImage.image = UIImage(named: note.iconName)
        noteTitleLable.text = note.title
        noteDescriptionLable.text = note.describtion
        noteLevelOfPriorityLable.text = note.levelOfPriority.description
        noteEndDateLable.text = dateFormater.string(from: note.endDate)
    }
}
