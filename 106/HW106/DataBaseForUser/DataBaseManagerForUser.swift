//
//  DataBaseManagerForUser.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 02.02.2024.
//

import UIKit

class DataBaseManagerForUser {
    
    static let shared = DataBaseManagerForUser()
    
    private let queue = OperationQueue()
    private let syncQueue = DispatchQueue(label: "com.example.syncQueue", attributes: .concurrent)
    private let dataSemaphore = DispatchSemaphore(value: 1)
    
    var dataSource: [User] = [
        User(login: "asb", password: "12345"),
        User(login: "b.o.o.m.b.a.s.t.i.c", password: "123"),
        User(login: "Gosha555", password: "353")
    ]
}
