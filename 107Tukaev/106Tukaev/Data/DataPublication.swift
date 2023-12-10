//
//  DataPublication.swift
//  106Tukaev
//
//  Created by surexnx on 30.10.2023.
//

import Foundation
import UIKit
class DataPublication {
    private let likesDefaults = UserDefaults(suiteName: "likes")
    private let likeKey = "saved_likes"

    private var publications: [Publication] = []

    init() {
        createPublication()
        setLikes(obtainLikes())
    }

    func createPublication() {
        publications = [
            Publication(1, 1, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12)),
            Publication(2, 2, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12)),
            Publication(3, 2, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12)),
            Publication(4, 3, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12)),
            Publication(5, 3, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12)),
            Publication(6, 2, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12)),
            Publication(7, 2, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12)),
            Publication(8, 1, "Публикация", [UIImage(named: "user")], createDate(2020, month: 10, day: 12))
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

    func setLikes(_ newData: [ObtainData]) {
        for likes in newData {
            if let index = publications.firstIndex(where: { $0.userId == likes.userId && $0.id == likes.publId }) {
                publications[index].setLikes(likes: likes.likesUsers)
            }
        }
    }

    func getPublications() -> [Publication] {
        return publications
    }

    func obtainLikes() -> [ObtainData] {

        guard let likesData = likesDefaults?.data(forKey: likeKey) else { return [] }

        do {
            let decoder = JSONDecoder()
            let likes = try decoder.decode([ObtainData].self, from: likesData)
            return likes
        } catch {
            print("Obtaining error: \(error)")
        }
        return []
    }
}

struct ObtainData: Codable {
    var userId: Int
    var publId: Int
    var likesUsers: [Int]
}
