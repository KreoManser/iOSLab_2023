//
//  Publication.swift
//  106Tukaev
//
//  Created by surexnx on 29.10.2023.
//
import UIKit
import Foundation

struct Publication: Hashable, Identifiable {
    let id: UUID
    let nameUser: String
    var description: String
    var images: [UIImage?]
    var date: String
}
