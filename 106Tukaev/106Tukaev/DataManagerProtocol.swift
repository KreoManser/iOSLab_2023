//
//  DataManagerProtocol.swift
//  106Tukaev
//
//  Created by surexnx on 31.10.2023.
//

import Foundation
protocol DataManagerProtocol {
    func syncSetPublication(_ publication: Publication)
    func asyncSetPublication(_ publication: Publication)
    func syncGetAll() -> [Publication]
    func asyncGetAll() -> [Publication]
    func syncSearchPublication(by id: UUID) -> Publication
    func asyncSearchPublication(by id: UUID) -> [Publication]
    func syncDeletePublication(id: UUID)
    func asyncDeletePublication(id: UUID)
}
