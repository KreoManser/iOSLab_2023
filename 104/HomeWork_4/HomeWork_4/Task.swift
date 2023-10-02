//
//  Task.swift
//  HomeWork_4
//
//  Created by Нияз Ризванов on 01.10.2023.
//

import Foundation

struct Task: Hashable, Identifiable {
    let id: UUID?
    let title:String?
    let description:String?
}
