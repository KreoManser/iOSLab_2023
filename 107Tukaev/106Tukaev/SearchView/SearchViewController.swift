//
//  SearchViewController.swift
//  107Tukaev
//
//  Created by surexnx on 11.12.2023.
//

import UIKit

class SearchViewController: UIViewController {

    private lazy var customView: SearchView = {
        return SearchView(frame: .zero)
    }()

    var dataSource: SearchDataSource = SearchDataSource()
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.controller = self
        customView.setupDataSource(dataSource)
        customView.setupTextFieldDelegate(delegate: self)
        customView.textChangeHandler = { text in
            self.dataSource.setSearchText(text: text)
            self.customView.reloadData()
        }
    }
}
extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customView.addTarger()
        }

    func textFieldDidEndEditing(_ textField: UITextField) {
        customView.removeTarger()
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        customView.removeTarger()
        customView.addTarger()
        return true
    }
}
