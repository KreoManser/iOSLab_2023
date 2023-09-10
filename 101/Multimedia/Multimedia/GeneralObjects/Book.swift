//
//  Book.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

class Book: MediaItem {
    let amountOfPages: Int
    
    init(name: String, author: String, rating: Double, genre: [String], amountOfPages: Int, typeOfmedia: TypeOfMedia, amountOfRatings: Int) {
        self.amountOfPages = amountOfPages
        super.init(name: name, author: author, rating: rating, genre: genre, typeOfmedia: typeOfmedia, amountOfRatings: amountOfRatings)
    }
    
    convenience init(item: MediaItem, amountOfPages: Int) {
        self.init(name: item.name, author: item.author, rating: item.rating, genre: item.genre, amountOfPages: amountOfPages, typeOfmedia: item.typeOfmedia, amountOfRatings: item.amountOfRatings)
    }
}
