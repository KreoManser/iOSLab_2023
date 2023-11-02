//
//  Profile.swift
//  106Tukaev
//
//  Created by surexnx on 30.10.2023.
//
import UIKit
import Foundation
struct User: Hashable, Identifiable {
    let userId: UUID
    let nameUser: String
    var description: String
    var images: [UIImage?]
    var date: Date
}
