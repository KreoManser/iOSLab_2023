//
//  Cat.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 06.11.2023.
//

import Foundation
struct Cat: Hashable, Identifiable {
    let id: String
    let name: String
    let login: String
    let password: String
    var publishers: [Publisher]
}
