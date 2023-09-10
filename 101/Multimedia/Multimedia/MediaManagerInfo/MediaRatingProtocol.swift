//
//  MediaRatingProtocol.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

protocol MediaRatingProtocol {
    func estimateItem(item: MediaItem, rating: Double)
    func givePopularItems(type: TypeOfMedia?)
}
