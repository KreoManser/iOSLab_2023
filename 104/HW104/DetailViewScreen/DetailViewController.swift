//
//  DetailViewController.swift
//  HW104
//
//  Created by Ильмир Шарафутдинов on 24.01.2024.
//

import UIKit
protocol DetailControllerDelegate: AnyObject {
    func dataUpdate()
    func updateDataBase(by task: Task?)
    func addNewTaskDataBase(by task: Task)
}

class DetailViewController: UIViewController {
    
    let modalView = DetailTaskView()
    
    var task: Task?
    weak var delegate: DetailControllerDelegate?
    
    init (delegate: DetailControllerDelegate?, task: Task?) {
        super.init (nibName: nil, bundle: nil)
        
        self.task = task
        self.delegate = delegate
    }
    
    required init? (coder: NSCoder) {
        fatalError ("init (coder:) has not been implemented" )
    }
    
    override func loadView() {
        view = modalView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalView.detailViewController = self
        modalView.fieldForModification.text = task?.title
        modalView.configurePriority(by: task)
        modalView.configureDate(by: task)
    }
    
    func updateTask() {
        task?.title = modalView.fieldForModification.text ?? ""
        delegate?.updateDataBase(by: task)
    }
    
    func addNewTask(task: Task) {
        delegate?.addNewTaskDataBase(by: task)
    }
}
