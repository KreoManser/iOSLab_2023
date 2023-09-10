//
//  MediaManagerProtocol.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

protocol MediaManagerProtocol {
    func findItemByName (name: String) -> [MediaItem]
    func findItemByAuthor (author: String) -> [MediaItem]
    func findItemByMediaType (type: TypeOfMedia) -> [MediaItem]
    
    func addItem(item: MediaItem)
    func deleteItem(item: MediaItem)
}


