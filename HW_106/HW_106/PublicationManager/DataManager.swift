//
//  DataManager.swift
//  HW_106
//
//  Created by Азат Зиганшин on 29.10.2023.
//

import Foundation
import UIKit

class DataManager: DataManagerProtocol {

    static let shared = DataManager()

    private init() {
        guard let remyBorn = UIImage(named: "remy_born") else {return}
        guard let remySleep = UIImage(named: "remy_sleep") else {return}
        guard let remySleeping = UIImage(named: "remy_sleeping") else {return}
        guard let remyWash = UIImage(named: "remy_wash") else {return}
        guard let remyEat = UIImage(named: "remy_eat") else {return}
        guard let remy = UIImage(named: "remy") else {return}
        publications = [
            Publication(userId: UUID(), photo: remyWash, text: "Я помылся"),
            Publication(userId: UUID(), photo: remyEat, text: "Тут я ем"),
            Publication(userId: UUID(), photo: remySleeping, text: "Это я уже сплю"),
            Publication(userId: UUID(), photo: remySleep, text: "Хочу поспать"),
            Publication(userId: UUID(), photo: remyBorn, text: "Это я только родился"),
            Publication(userId: UUID(), photo: remy, text: "Добро пожаловать на мой аккаунт")
        ]
    }

    private var publications: [Publication] = []
    let semaphore = DispatchSemaphore(value: 1)

    func syncSavePublication(_ publication: Publication) {
        semaphore.wait()
        publications.append(publication)
        semaphore.signal()
    }

    func asyncSavePublication(_ publication: Publication, completion: @escaping () -> Void) {

        let operationQueue = OperationQueue()

        let saveOperation = BlockOperation { [weak self] in
            self?.syncSavePublication(publication)
            completion()
        }

        operationQueue.addOperation(saveOperation)
    }

    func syncGetPublication(byId id: UUID) -> Publication? {

        semaphore.wait()
        let result = publications.first { $0.id == id }
        semaphore.signal()
        return result

    }

    func asyncGetPublication(byId id: UUID, completion: @escaping (Publication?) -> Void) {

        var result: Publication?
        let operationQueue = OperationQueue()

        let getOperation = BlockOperation { [weak self] in
            result = self?.syncGetPublication(byId: id)
            completion(result)
        }

        operationQueue.addOperation(getOperation)
    }

    func syncDeletePublication(byId id: UUID) {

        semaphore.wait()
        let index = publications.firstIndex { $0.id == id }
        if let index {
            publications.remove(at: index)
        }
        semaphore.signal()
    }

    func asyncDeletePublication(byId id: UUID, completion: @escaping () -> Void) {

        let operationQueue = OperationQueue()

        let deleteOperation = BlockOperation { [weak self] in
            self?.syncDeletePublication(byId: id)
            completion()
        }

        operationQueue.addOperation(deleteOperation)
    }

    func syncGetAllPublications() -> [Publication] {
        semaphore.wait()
        let result = publications
        semaphore.signal()
        return result
    }

    func asyncGetAllPublications(completion: @escaping ([Publication]) -> Void) {

        let operationQueue = OperationQueue()
        var result: [Publication] = []

        let operation = BlockOperation { [weak self] in
            result = self?.syncGetAllPublications() ?? []
            completion(result)
        }

        operationQueue.addOperation(operation)
    }

    func syncDeletePublication(withIndex index: Int) {
        semaphore.wait()
        publications.remove(at: index)
        semaphore.signal()
    }

    func asyncDeletePublication(withIndex index: Int, completion: @escaping () -> Void) {

        let operationQueue = OperationQueue()

        let operation = BlockOperation { [weak self] in
            self?.publications.remove(at: index)
            completion()
        }

        operationQueue.addOperation(operation)
    }
}
