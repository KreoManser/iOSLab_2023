//
//  DataManagerProtocol.swift
//  CaTGramm
//
//  Created by Rustem on 28.10.2023.
//

import Foundation

protocol DataManagerProtocol {
    func syncSave(_ picture: Post)
    func asyncSave(_ picture: Post)
    func syncGetModel(_ picture: Post)
    func asyncGetModel(_ picture: Post)
    func syncDeleteModel(_ picture: Post)
    func asyncDeleteModel(_ picture: Post)
    func syncSearchModel(_ name: String)
    func asyncSearchModel(_ name: String)
}
