//
//  Cat.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 06.11.2023.
//

import Foundation
import UIKit
struct User {
    let nickName: String
    let fullName: String
    let login: String
    let password: String
    let imageAvatar: UIImage?
    var publications: [Publication] = []
    var subscriptions: [User] = []
    var numberPublications: Int {return publications.count}
    var numberSubscribers: Int
    var numberSubscriptions: Int
    var description: String
}
