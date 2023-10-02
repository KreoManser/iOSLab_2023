//
//  NotesTableViewCellDelegate.swift
//  NotesApp
//
//  Created by Mac on 2023-10-02.
//

import Foundation

protocol NotesTableViewCellDelegate {
    func changeStatusOfNote(note: Note, isDone: Bool)
}
