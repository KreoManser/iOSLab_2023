//
//  ProfileModel.swift
//  New106
//
//  Created by Alina on 01.11.2023.
//

import Foundation
 import UIKit

 struct Post: Equatable, Identifiable {
     let id: UUID
     let image: UIImage?
     let caption: String
     let date: String
 }
