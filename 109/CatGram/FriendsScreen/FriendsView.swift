//
//  FriendsView.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 26.11.2023.
//

import UIKit

class FriendsView: UIView {
    lazy var segmentedButtons: UISegmentedControl = UISegmentedControl(items: ["Following", "Followers"])

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSegments()
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
}
