//
//  Publisher.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 30.10.2023.
//

import UIKit

struct Publication: Codable {
    let id: UUID?
    let imageAvatarData: Data?
    let label: String?
    let description: String?
    let date: String?
    let imageData: Data?
    var likes: [String] = []

    // Добавьте инициализатор, чтобы преобразовать UIImage в Data при создании объекта
    init(id: UUID?, imageAvatar: UIImage?, label: String?, description: String?, date: String?, image: UIImage?) {
        self.id = id
        self.label = label
        self.description = description
        self.date = date

        // Преобразуйте UIImage в Data
        self.imageAvatarData = imageAvatar?.pngData()
        self.imageData = image?.pngData()
    }
}
