//
//  DataManagerProtocol.swift
//  CaTGramm
//
//  Created by Rustem on 28.10.2023.
//

import Foundation

protocol DataManagerProtocol {
    func syncSave(_ picture: PictureModel)
    func asyncSave(_ picture: PictureModel)
    func syncGetModel(_ picture: PictureModel)
    func asyncGetModel(_ picture: PictureModel)
    func syncDeleteModel(_ picture: PictureModel)
    func asyncDeleteModel(_ picture: PictureModel)
    func syncSearchModel(_ name: String)
    func asyncSearchModel(_ name: String)
}
