//
//  Publication.swift
//  106Tukaev
//
//  Created by surexnx on 29.10.2023.
//
import UIKit
import Foundation

struct Publication: Hashable, Identifiable {
    let id: Int
    let userId: Int
    var description: String
    var images: [UIImage?]
    var date: Date
}
