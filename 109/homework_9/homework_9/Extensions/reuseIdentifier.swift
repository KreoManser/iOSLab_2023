//
//  reuseIdentifier.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
