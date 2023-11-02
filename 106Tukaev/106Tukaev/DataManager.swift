//
//  DataManager.swift
//  106Tukaev
//
//  Created by surexnx on 31.10.2023.
//

import Foundation

class DataManager: DataManagerProtocol {

    private var publications = DataPublication().publications

    func setDataPublication(publications: [Publication]) {
        self.publications = publications
    }

    func syncSetPublication(_ publication: Publication) {
        self.publications.append(publication)
    }
    func asyncSetPublication(_ publication: Publication) {
        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            self.publications.append(publication)
        }
        operation.completionBlock = {
        }

        operationQueue.addOperation(operation)
    }
    func syncGetAll() -> [Publication] {
        return publications
    }
    func asyncGetAll() -> [Publication] {
        var publications: [Publication] = []

        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            publications = self.publications
        }
        operation.completionBlock = {
        }

        operationQueue.addOperation(operation)
        return publications
    }
    func syncSearchPublication(by id: UUID) -> Publication {
        return self.publications.first(where: { $0.id.uuidString == id.uuidString })!
    }

    func asyncSearchPublication(by id: UUID) -> [Publication] {
        var publication: [Publication] = []
        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            publication.append(self.publications.first(where: { $0.id.uuidString == id.uuidString})!)
        }
        operation.completionBlock = {
        }
        operationQueue.addOperation(operation)
        return publication
    }
    func syncDeletePublication(id: UUID) {
        if let index = publications.firstIndex(where: { $0.id == id}) {
            publications.remove(at: index)
        }
    }
    func asyncDeletePublication(id: UUID) {
        let operationQueue = OperationQueue()
        let operation = BlockOperation {
            if let index = self.publications.firstIndex(where: { $0.id == id}) {
                self.publications.remove(at: index)
            }
        }
        operation.completionBlock = {
        }
        operationQueue.addOperation(operation)
    }
}
