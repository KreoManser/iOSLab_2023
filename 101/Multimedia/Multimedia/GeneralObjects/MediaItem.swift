//
//  File.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

class MediaItem: Equatable {
    static func == (lhs: MediaItem, rhs: MediaItem) -> Bool {
        return
            lhs.typeOfmedia == lhs.typeOfmedia &&
            lhs.rating == lhs.rating &&
            lhs.name == lhs.name &&
            lhs.genre == lhs.genre &&
            lhs.author == lhs.author &&
            lhs.amountOfRatings == lhs.amountOfRatings
    }
    
    let name: String
    let author: String
    var rating: Double
    var amountOfRatings: Int
    let genre: [String]
    let typeOfmedia: TypeOfMedia
    
    init(name: String, author: String, rating: Double, genre: [String], typeOfmedia: TypeOfMedia, amountOfRatings: Int) {
        self.name = name
        self.author = author
        self.rating = rating
        self.genre = genre
        self.typeOfmedia = typeOfmedia
        self.amountOfRatings = amountOfRatings
    }
}



