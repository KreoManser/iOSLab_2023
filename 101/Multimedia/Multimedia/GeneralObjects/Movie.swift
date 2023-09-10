//
//  File.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

class Movie: MediaItem {
    let duration: Double
    
    init(name: String, author: String, rating: Double, genre: [String], duration: Double, typeOfmedia: TypeOfMedia, amountOfRatings: Int) {
        self.duration = duration
        super.init(name: name, author: author, rating: rating, genre: genre, typeOfmedia: typeOfmedia, amountOfRatings: amountOfRatings)
    }
    
    convenience init(item: MediaItem, duration: Double) {
        self.init(name: item.name, author: item.author, rating: item.rating, genre: item.genre, duration: duration, typeOfmedia: item.typeOfmedia, amountOfRatings: item.amountOfRatings)
    }
}
