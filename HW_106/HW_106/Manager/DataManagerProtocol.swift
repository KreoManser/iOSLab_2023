//
//  DataManagerProtocol.swift
//  HW_106
//
//  Created by Азат Зиганшин on 29.10.2023.
//

import Foundation

protocol DataManagerProtocol {

    func syncSavePublication(_ publication: Publication)
    func asyncSavePublication(_ publication: Publication)

    func syncGetPublication(byId id: UUID) -> Publication?
    func asyncGetPublication(byId id: UUID) -> Publication?

    func syncDeletePublication(byId id: UUID)
    func asyncDeletePublication(byId id: UUID)

    func syncGetAllPublications() -> [Publication]
    func asyncGetAllPublications() -> [Publication]

    func syncDeletePublication(withIndex index: Int)
    func asyncDeletePublication(withIndex index: Int)
}
