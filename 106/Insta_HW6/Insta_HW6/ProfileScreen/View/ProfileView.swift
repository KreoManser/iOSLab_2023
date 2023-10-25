//
//  ProfileView.swift
//  Insta_HW6
//
//  Created by Камил Хайрутдинов on 25.10.2023.
//

import UIKit

class ProfileView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView {
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
    private func configureUI() {
    }
}
