//
//  PostButton.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 26.11.2023.
//

import Foundation
import UIKit

class PostButton {
    static var configureation: UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 2
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        return configuration
    }
}
