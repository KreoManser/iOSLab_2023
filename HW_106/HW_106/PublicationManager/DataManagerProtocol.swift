//
//  DataManagerProtocol.swift
//  HW_106
//
//  Created by Азат Зиганшин on 29.10.2023.
//

import Foundation

protocol DataManagerProtocol {

    func syncSavePublication(_ publication: Publication)
    func asyncSavePublication(_ publication: Publication, completion: @escaping () -> Void)

    func syncGetPublication(byId id: UUID) -> Publication?
    func asyncGetPublication(byId id: UUID, completion: @escaping (Publication?) -> Void)

    func syncDeletePublication(byId id: UUID)
    func asyncDeletePublication(byId id: UUID, completion: @escaping () -> Void)

    func syncGetAllPublications() -> [Publication]
    func asyncGetAllPublications(completion: @escaping ([Publication]) -> Void)

    func syncDeletePublication(withIndex index: Int)
    func asyncDeletePublication(withIndex index: Int, completion: @escaping () -> Void)
}
