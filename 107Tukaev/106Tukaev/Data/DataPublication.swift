//
//  DataPublication.swift
//  106Tukaev
//
//  Created by surexnx on 30.10.2023.
//

import Foundation
import UIKit
class DataPublication {

    private var publications: [Publication] = []

    init() {
        createPublication()
    }

    func createPublication() {
        publications = [
            Publication(id: 1, userId: 1, description: "Публикация", images: [UIImage(named: "user")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 2, userId: 2, description: "Публикация", images: [UIImage(named: "user")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 3, userId: 3, description: "Публикация", images: [UIImage(named: "user")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 4, userId: 1, description: "Публикация", images: [UIImage(named: "user")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 5, userId: 2, description: "Публикация", images: [UIImage(named: "Cat")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 6, userId: 3, description: "Публикация", images: [UIImage(named: "user")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 7, userId: 1, description: "Публикация", images: [UIImage(named: "Cat")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 8, userId: 2, description: "Публикация", images: [UIImage(named: "user")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 9, userId: 3, description: "Публикация", images: [UIImage(named: "Cat")], date: createDate(2020, month: 10, day: 12)),
            Publication(id: 10, userId: 1, description: "Публикация", images: [UIImage(named: "user")], date: createDate(2020, month: 10, day: 12))
        ]
    }

    private func createDate(_ year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        var date = Date()
        if let dateCalendar = calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)) {
            date = dateCalendar
        }
        return date
    }

    func getPublications() -> [Publication] {
        return publications
    }
}
