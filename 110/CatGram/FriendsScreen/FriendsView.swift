//
//  FriendsView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 26.11.2023.
//

import UIKit

class FriendsView: UIView {
    lazy var segmentedButtons: UISegmentedControl = UISegmentedControl(items: ["Following", "Followers"])
    lazy var tableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegments()
        setUpTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupSegments() {
        addSubview(segmentedButtons)
        segmentedButtons.translatesAutoresizingMaskIntoConstraints = false
        segmentedButtons.selectedSegmentIndex = 0
        segmentedButtons.tintColor = .black

        NSLayoutConstraint.activate([
            segmentedButtons.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedButtons.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            segmentedButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    private func setUpTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
     //   tableView.backgroundColor = .red
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedButtons.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
