//
//  ViewController.swift
//  HW5
//
//  Created by Kseniya Skvortsova on 12.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let COMMANDS : [String] = ["AC","<-","->","÷","x","-","+","=", "C"]
    private let SYMBOLS : [String] = [".","0","1","2","3","4","5","6","7","8","9"]
    
    private var result = "-"
    private var numberDouble = 0.0
    private var isDouble1 = false
    private var isDouble = false
    private var command = -1
    private var prevResult="-"
    
    private lazy var resultLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 80)
        view.textColor = .white
        view.numberOfLines = 0
        view.text="0"
        view.textAlignment = .right
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.isScrollEnabled=false
        table.register(ButtonTableViewCell.self, forCellReuseIdentifier: ButtonTableViewCell.reuseIdentifier)
        return table
    }()
    
    var dataSource: [Button] = []
    
    var tableBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = generateData()
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        
        setupLayout()
    }
    
    func generateData()->[Button]{
        let data:[Button] = [Button(type: ["AC","<-","->","÷"], color: false),
                             Button(type: ["7","8","9","x"], color: true),
                             Button(type: ["4","5","6","-"], color: true),
                             Button(type: ["1","2","3","+"], color: true),
                             Button(type: ["0","C",".","="], color: true)]
        return data
    }
    
    func setupLayout() {
        
        let value=UIScreen.main.bounds.height-(((UIScreen.main.bounds.width-25)/4)+10)*5-resultLabel.font.lineHeight
        
        print(resultLabel.numberOfLines)
        
        view.addSubview(tableView)
        view.addSubview(resultLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: value-10),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            tableView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath) as! ButtonTableViewCell
        
        let button = dataSource[indexPath.row]
        cell.configureCell(with: button)
        cell.delegate = self
        cell.backgroundColor = .black
        
        return cell
    }
}

extension ViewController: ButtonCellDelegate {
    
    func buttonTapped(for button: String) {
        
        for i in 0...COMMANDS.count-1 {
            if COMMANDS[i]==button{
                commandTapped(i: i)
                break
            }
        }

        for i in 0...SYMBOLS.count-1 {
            if SYMBOLS[i]==button{
                symbolTapped(symbol: button)
                break
            }
        }
        
    }
    
    func commandTapped(i: Int){
        if i==0{
            result="-"
            isDouble=false
            isDouble1=false
            numberDouble=0
            resultLabel.text="0"
        }
        else if i==7, command>0{
            
            if command == 3{
                result=String(numberDouble/(Double(result) ?? 0))
                if !isDouble,!isDouble1, Int(numberDouble) % (Int(result) ?? -1)==0{
                    result.remove(at: result.index(before: result.endIndex))
                    result.remove(at: result.index(before: result.endIndex))
                }
                else{
                    isDouble1=true
                }
            }
            else{
                if command == 4{
                    result=String(numberDouble*(Double(result) ?? 0))
                }
                else if command == 5{
                    result=String(numberDouble-(Double(result) ?? 0))
                }
                else if command == 6{
                    result=String(numberDouble+(Double(result) ?? 0))
                }
                if !isDouble,!isDouble1{
                    result.remove(at: result.index(before: result.endIndex))
                    result.remove(at: result.index(before: result.endIndex))
                }
                else{
                    isDouble1=true
                }
            }
            numberDouble = Double(result) ?? 0
            isDouble=false
            resultLabel.text = result
        }
        else if i==8{
            if result[result.index(before: result.endIndex)] == "."{
                isDouble=false
            }
            result.remove(at: result.index(before: result.endIndex))
            if result==""{
                result="-"
                numberDouble=0
                resultLabel.text="0"
            }
            else{
                resultLabel.text=result
            }
        }
        else {
            command=i
            if result[result.index(before: result.endIndex)] == "."{
                result.remove(at: result.index(before: result.endIndex))
                isDouble=false
            }
            isDouble1=isDouble
            isDouble=false
            numberDouble=Double(result) ?? 0
            result="-"
            resultLabel.text="0"
        }
    }
    
    func symbolTapped(symbol: String){
        if symbol=="."{
            isDouble=true
            if result != "-"{
                result.append(symbol)
                resultLabel.text=result
            }
        }
        
        else{
            if result=="-"{
                result=symbol
            }
            else{
                result.append(symbol)
            }
            resultLabel.text=result
        }
    }
}
