//
//  File.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

class Music: MediaItem {
    let album: String
    
    init(name: String, author: String, rating: Double, genre: [String], album: String, typeOfmedia: TypeOfMedia, amountOfRatings: Int) {
        self.album = album
        super.init(name: name, author: author, rating: rating, genre: genre, typeOfmedia: typeOfmedia, amountOfRatings: amountOfRatings)
    }
    
    convenience init(item: MediaItem, album: String) {
        self.init(name: item.name, author: item.author, rating: item.rating, genre: item.genre, album: album, typeOfmedia: item.typeOfmedia, amountOfRatings: item.amountOfRatings)
    }
}

