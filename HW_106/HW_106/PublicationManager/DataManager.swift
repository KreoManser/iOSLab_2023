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
        publications = [
            Publication(userId: "1", photo: UIImage(named: "remy_wash"), text: "Я помылся"),
            Publication(userId: "2", photo: UIImage(named: "warmup"), text: "Утро начинается с разминки"),
            Publication(userId: "3", photo: UIImage(named: "catAndSea"), text: "я у моря"),
            Publication(userId: "1", photo: UIImage(named: "remy_eat"), text: "Тут я ем"),
            Publication(userId: "2", photo: UIImage(named: "fastCat"), text: "Я настолько быстр, что даже камера не может меня уловить"),
            Publication(userId: "3", photo: UIImage(named: "catInEgypt"), text: "нахожусь на родине своих предков"),
            Publication(userId: "1", photo: UIImage(named: "remy_sleeping"), text: "Это я уже сплю"),
            Publication(userId: "2", photo: UIImage(named: "powerfulcat"), text: "Моя любовь к спорту началась с самого детства"),
            Publication(userId: "3", photo: UIImage(named: "catWithPiza"), text: "никакого фотошопа - я удерживаю пизанскую башню"),
            Publication(userId: "1", photo: UIImage(named: "remy_sleep"), text: "Хочу поспать"),
            Publication(userId: "2", photo: UIImage(named: "catWithOwner"), text: "Хозяин тоже поддерживает мою любовь к спорту"),
            Publication(userId: "3", photo: UIImage(named: "catInJapan"), text: "Люблю Японию"),
            Publication(userId: "1", photo: UIImage(named: "remy_born"), text: "Это я только родился"),
            Publication(userId: "2", photo: UIImage(named: "dinner"), text: "Обэд спортсмэна"),
            Publication(userId: "3", photo: UIImage(named: "catInParis"), text: "я в пагиже"),
            Publication(userId: "1", photo: UIImage(named: "remy"), text: "Добро пожаловать на мой аккаунт"),
            Publication(userId: "3", photo: UIImage(named: "catInRussia"), text: "встретил своих друзей в России"),
            Publication(userId: "3", photo: UIImage(named: "catInSpace"), text: "Ухожу на пару дней из соц.сетей: отправляюсь в космос")
        ]
    }

    private var publications: [Publication] = []
    let locker = NSLock()

    func syncSavePublication(_ publication: Publication) {
        locker.lock()
        publications.append(publication)
        locker.unlock()
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

        locker.lock()
        let result = publications.first { $0.id == id }
        locker.unlock()
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

        locker.lock()
        let index = publications.firstIndex { $0.id == id }
        if let index {
            publications.remove(at: index)
        }
        locker.unlock()
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
        locker.lock()
        let result = publications
        locker.unlock()
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
        locker.lock()
        publications.remove(at: index)
        locker.unlock()
    }

    func asyncDeletePublication(withIndex index: Int, completion: @escaping () -> Void) {

        let operationQueue = OperationQueue()

        let operation = BlockOperation { [weak self] in
            self?.publications.remove(at: index)
            completion()
        }

        operationQueue.addOperation(operation)
    }

    func syncGetPublications(byUserId userId: String) -> [Publication]? {

        locker.lock()
        let result = publications.filter { $0.userId == userId }
        locker.unlock()
        return result
    }

    func asyncGetPublications(byUserId userId: String) async -> [Publication]? {

        let queue = OperationQueue()

        return await withCheckedContinuation { continuation in
            queue.addOperation {
                continuation.resume(returning: self.syncGetPublications(byUserId: userId))
            }
        }
    }
}
