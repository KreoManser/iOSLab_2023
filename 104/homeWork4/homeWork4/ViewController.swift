//
//  ViewController.swift
//  homeWork4
//
//  Created by marwa awwad mohamed awwad on 30.09.2023.
//

import UIKit
 
class ViewController: UIViewController{
    
    
    enum TableSection {
        case main
        case secondary
    }
    
    
    lazy var tableView: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.separatorStyle = .none 
        table.register(contentsOfEachDayTableViewCell.self, forCellReuseIdentifier: contentsOfEachDayTableViewCell.reuseIdentifier)
        table.estimatedRowHeight = 140
        return table
    }()
    
    
    
    var todayList:[Time] = []
    var dataSource: UITableViewDiffableDataSource<TableSection, Time>?
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
             constantLabels()
             setUpNavigationBar()
             setUpLayout()
             setupViewDataSource()
             updateDataSource(with: todayList, animate: false)
        save()
              
        
    }
    @objc func handleEditTap() {
        tableView.isEditing.toggle()
        if !tableView.isEditing {
            tableView.reloadData()
        }
    }
    func save() {
        var notesToBeSaved: [String] = []
        
        for todo in todayList {
            notesToBeSaved.append(todo.description)
        }
        
        UserDefaults.standard.set(notesToBeSaved, forKey: "todo")
        
        
        UserDefaults.standard.synchronize()
    }

    
    func setupViewDataSource(){


         dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: {
             tableView, IndexPath, time in
             let cell = tableView.dequeueReusableCell(withIdentifier: contentsOfEachDayTableViewCell.reuseIdentifier, for: IndexPath)
             as! contentsOfEachDayTableViewCell
             cell.configureCell(with: time)
              
             return cell
             
         })
        updateDataSource(with: todayList,animate: false)
       
    }
    func updateDataSource(with todayList: [Time], animate: Bool){
        var snapshot = NSDiffableDataSourceSnapshot<TableSection, Time>()
        snapshot.appendSections([.main])
        snapshot.appendItems(todayList)
        dataSource?.apply(snapshot, animatingDifferences:animate)
        
    }
     
    //these constant cells to every normal day and any addetional lists for upnormal once like event or weekend plans
    func constantLabels(){
        for _ in 0..<1  {
            let dayTime = ["morning", "afernoon", "evening", "night"]
       
            for word in dayTime {
                var desc : String
                if (word == "morning"){
                    desc = "good morning in the morning i have to wake up at 7 am, drink water, take your breakfast, do your bed,take my coffe and laptop  go to the university"
                }else if (word == "afernoon"){
                    desc =  "good afternoon, now i have to have my lunch, take a nap "
                }else if (word == "evening"){
                    desc = " good evening now i should be doing my hw and send it "
                }else{desc = "good night, have nice dreams"}
                todayList.append(Time(id: UUID() ,time: word, avater: UIImage(named: "done"), done: "check", description: desc))            }
        }
    
        
    }
        func setUpNavigationBar(){
       
            let editAction = UIAction { _ in
                self.tableView.isEditing.toggle()
                if !self.tableView.isEditing{
                    self.tableView.reloadData()
                }
               
            }

            let addAction = UIAction { [weak self] _ in
                guard let self = self else { return }

                
                let alert = UIAlertController(title: "Add todo", message: nil, preferredStyle: .alert)
                
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Enter a todo"
                }
                
                
                let submitAction = UIAlertAction(title: "add note", style: .default) { [weak alert] (action) in
                    guard let textField = alert?.textFields?.first, let text = textField.text, !text.isEmpty else {
                        return
                    }
                    
                    let currentDate = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm"
                    let formattedDate = dateFormatter.string(from: currentDate)
                    
                    let newEvent = Time(id: UUID(),
                                        time: formattedDate,
                                        avater: UIImage(named: "done"),
                                        done: "check",
                                        description: text)

                    // Safely unwrap the snapshot and append the new event
                    if var snapshot = self.dataSource?.snapshot() {
                        snapshot.appendItems([newEvent], toSection: .main)
                        self.dataSource?.apply(snapshot)
                    }
                    
                    //to dismiss the alert
                    alert?.dismiss(animated: true, completion: nil)
                }
                
                
                alert.addAction(submitAction)
                
                
                self.present(alert, animated: true, completion: nil)
            }




                navigationItem.title = "TODO list "
                navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .edit,  primaryAction: editAction ,menu: nil)
                navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add,  primaryAction: addAction ,menu: nil)

        }
        func setUpLayout() {
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
    }
    


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newNote = dataSource?.itemIdentifier(for: indexPath){
            navigationController?.pushViewController(detailTableViewCell(with: newNote),animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todayList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            save()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: contentsOfEachDayTableViewCell.reuseIdentifier, for: indexPath) as! contentsOfEachDayTableViewCell
        let time = todayList[indexPath.row]
        cell.configureCell(with: time)
        return cell
    }
}
