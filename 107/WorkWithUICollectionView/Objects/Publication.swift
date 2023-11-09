//
//  Publisher.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 30.10.2023.
//

import Foundation
import UIKit

struct Publication: Identifiable {
    let id: UUID?
    let imageAvatar: UIImage?
    let label: String?
    let description: String?
    let date: String?
    let image: UIImage?
}
