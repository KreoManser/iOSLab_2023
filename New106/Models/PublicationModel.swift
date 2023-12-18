//
//  PostModel.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import Foundation
 import UIKit

 struct Publication: Equatable, Identifiable {
     var avatarImage: UIImage? = UIImage(named: "7")
     var username: String = "RadzhaaaCat"
     let id: UUID
     let postImage: UIImage?
     let caption: String
     let date: String
 }
