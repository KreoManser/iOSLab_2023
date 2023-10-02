//
//  NotesViewController.swift
//  NotesApp
//
//  Created by Mac on 2023-10-01.
//

import UIKit

class NotesViewController: UIViewController {
    // MARK: - Declaration objects
    private lazy var notesTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.reuseIdentifier)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60
        table.backgroundColor = .white
        table.delegate = self
        return table
    }()
    
    private var notes: [Note] = [
        Note(title: "title", describtion: "fghjcfvgbhcvbggdfghjhgdfgtyuhbghjhbhgv", iconName: "icon", endDate: Date(), levelOfPriority: LevelOfPrority(rawValue: 1)!, isDone: false),
        Note(title: "gh", describtion: "fgh", iconName: "icon", endDate: Date(), levelOfPriority: LevelOfPrority(rawValue: 1)!, isDone: false),
        Note(title: "gh", describtion: "fgh", iconName: "icon", endDate: Date(), levelOfPriority: LevelOfPrority(rawValue: 1)!, isDone: false),
    ]
    
    private var oldNote: Note?
    private var dataSourse: UITableViewDiffableDataSource<TableSection, Note>?
    
    // MARK: - Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayouts()
        setupDataSourse()
        updateDataSourse(with: notes)
        setupNavigationBar()
    }
}

// MARK: - Constraints
extension NotesViewController {
    private func setupLayouts() {
        view.addSubview(notesTable)
        
        NSLayoutConstraint.activate([
            notesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            notesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            notesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            notesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Diffable Data Sourse
extension NotesViewController {
    private func setupDataSourse() {
        dataSourse = UITableViewDiffableDataSource(tableView: notesTable, cellProvider: { tableView, indexPath, note in
            let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.reuseIdentifier, for: indexPath) as! NotesTableViewCell
            cell.configureCell(with: note)
            cell.delegate = self
            return cell
        })
    }
    
    private func updateDataSourse(with notes: [Note]) {
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Note>()
        snapshot.appendSections([.main])
        snapshot.appendItems(notes)
        dataSourse?.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Navigation Bar
extension NotesViewController {
    private func setupNavigationBar() {
        let addNoteAction = UIAction { _ in
            let editNoteVC = EditNoteViewController()
            editNoteVC.delegate = self
            self.navigationController?.pushViewController(editNoteVC, animated: true)
        }
        
        navigationItem.title = "Notes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addNoteAction, menu: nil)
        navigationItem.rightBarButtonItem = self.addMenu()
    }
}

// MARK: - Table Protocols
extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let note = dataSourse?.itemIdentifier(for: indexPath) {
            let editNoteVC = EditNoteViewController(with: note)
            editNoteVC.delegate = self
            navigationController?.pushViewController(editNoteVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
            self.oldNote = note
        }
    }
}

// MARK: - Custom Delegate
extension NotesViewController: EditNoteDelegate {
    func changeNote(with newNote: Note) {
        if let index = self.notes.firstIndex(where: { $0 == oldNote }) {
            notes[index] = newNote
            updateDataSourse(with: notes)
        } else {
            notes.append(newNote)
            updateDataSourse(with: notes)
        }
    }
}

extension NotesViewController: NotesTableViewCellDelegate {
    func changeStatusOfNote(note: Note, isDone: Bool) {
        if let index = self.notes.firstIndex(where: { $0 == note }) {
            notes[index].isDone = isDone
            updateDataSourse(with: notes)
        } else {
            return
        }
    }
}

// MARK: - Support things
extension NotesViewController {
    private func addMenu() -> UIBarButtonItem {
        let getOldNotesFirst = UIAction(title: "Old") { _ in
            let notes = self.notes.sorted { $0.startDate < $1.startDate }
            self.updateDataSourse(with: notes)
        }
        let getNewNotesFirst = UIAction(title: "New") { _ in
            let notes = self.notes.sorted { $0.startDate > $1.startDate }
            self.updateDataSourse(with: notes)
        }
        let getNearToDeadLineFirst = UIAction(title: "Deadline is coming soon") { _ in
            let notes = self.notes.sorted { $0.endDate < $1.endDate }
            self.updateDataSourse(with: notes)
        }
        let getFartherToDeadLineFirst = UIAction(title: "Deadline is not coming soon") { _ in
            let notes = self.notes.sorted { $0.endDate > $1.endDate }
            self.updateDataSourse(with: notes)
        }
        let getHigthPriorityFirst = UIAction(title: "Higth priority") { _ in
            let notes = self.notes.sorted { $0.levelOfPriority.rawValue > $1.levelOfPriority.rawValue }
            self.updateDataSourse(with: notes)
        }
        let getLowPriorityFirst = UIAction(title: "Low priority") { _ in
            let notes = self.notes.sorted { $0.levelOfPriority.rawValue < $1.levelOfPriority.rawValue }
            self.updateDataSourse(with: notes)
        }

        let contextMenu = UIMenu(title: "Filter your notes", children: [getOldNotesFirst, getNewNotesFirst, getNearToDeadLineFirst, getHigthPriorityFirst, getFartherToDeadLineFirst, getLowPriorityFirst])
        let contextMenuButton = UIBarButtonItem(systemItem: .bookmarks, menu: contextMenu)

        return contextMenuButton
    }
}

