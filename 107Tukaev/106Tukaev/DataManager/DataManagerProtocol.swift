//
//  DataManagerProtocol.swift
//  106Tukaev
//
//  Created by surexnx on 31.10.2023.
//

import Foundation
protocol DataManagerProtocol {
    associatedtype T
    func syncSet(_ essence: T)
    func asyncSet(_ essence: T) async
    func syncGetAll() -> [T]
    func asyncGetAll() async -> [T]
    func syncSearch(by id: Int) -> T?
    func asyncSearch(by id: Int) async -> T?
    func syncDelete(id: Int)
    func asyncDelete(id: Int) async
}
