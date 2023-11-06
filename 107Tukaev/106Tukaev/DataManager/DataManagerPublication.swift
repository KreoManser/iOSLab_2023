//
//  DataManager.swift
//  106Tukaev
//
//  Created by surexnx on 31.10.2023.
//

import Foundation

class DataManagerPublication: DataManagerProtocol {

    private var user: User?

    func setUser(user: User) {
        self.user = user
    }

    func getUser() -> User {
        if let user = self.user {
            return user
        }
        return User()
    }

    static let shared = DataManagerPublication()

    private init() {}

    private var publications: [Publication] = DataPublication().getPublications()

    func setDataPublication(publications: [Publication]) {
        self.publications = publications
    }

    func syncSet(_ publication: Publication) {
        self.publications.append(publication)
    }

    func asyncSet(_ essence: Publication) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                self.publications.append(essence)
                continuation.resume()
            }
        }
    }

    func syncGetAll() -> [Publication] {
        return publications
    }
    func asyncGetAll() async -> [Publication] {
        await withCheckedContinuation { continuation in
            continuation.resume(returning: publications)
        }
    }
    func syncSearch(by id: Int) -> Publication? {
        return self.publications.first(where: { $0.id == id }) ?? nil
    }

    func asyncSearch(by id: Int) async -> Publication? {
        await withCheckedContinuation { continiation in
            DispatchQueue.global().async {
                continiation.resume(returning: self.publications.first(where: { $0.id == id }) ?? nil)
            }
        }
    }

    func syncDelete(id: Int) {
        if let index = publications.firstIndex(where: { $0.id == id }) {
            publications.remove(at: index)
        }
    }

    func asyncDelete(id: Int) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                if let index = self.publications.firstIndex(where: { $0.id == id }) {
                    self.publications.remove(at: index)
                }
                continuation.resume()
            }
        }
    }

    func syncGetPublicationByUserId() -> [Publication] {
        return self.publications.filter { $0.userId == self.user?.id }
    }

    func asyncGetPublicationByUserId() async -> [Publication] {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                let publications = self.publications.filter { $0.userId == self.user?.id }
                continuation.resume(returning: publications)
            }
        }
    }

    func asyncGetSubsriptionPublication() async -> [Publication] {
        await withCheckedContinuation { continuation in
            DispatchQueue.global().async {
                var publications: [Publication] = []
                self.user?.userSubscription.forEach { id in
                    publications += self.publications.filter { $0.userId == id }
                }
                continuation.resume(returning: publications)
            }
        }
    }

    func syncGetSubsriptionPublication() -> [Publication] {
        var publications: [Publication] = []
        self.user?.userSubscription.forEach { id in
            publications += self.publications.filter { $0.userId == id }
        }
        return publications
    }
}
