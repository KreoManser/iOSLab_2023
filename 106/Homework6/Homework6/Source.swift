//
//  Source.swift
//  Homework6
//
//  Created by kerik on 29.10.2023.
//

import Foundation

struct Source {
    static func allPhotos() -> [Photo] {
        [
            Photo(id: 1, imageName: "cat1"),
            Photo(id: 2, imageName: "cat2"),
            Photo(id: 3, imageName: "cat3"),
            Photo(id: 4, imageName: "cat4"),
            Photo(id: 5, imageName: "cat5"),
            Photo(id: 6, imageName: "cat6"),
            Photo(id: 7, imageName: "cat7")
        ]
    }
    static func randomPhoto(with count: Int) -> [Photo] {
        return (0 ..< count).map { _ in allPhotos().randomElement() ?? Photo(id: 1, imageName: "cat1") }
    }
}

class Photo {
    let id: Int
    let imageName: String

    init(id: Int, imageName: String) {
        self.id = id
        self.imageName = imageName
    }
}
