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
            Publication(photo: remyBorn, text: "Это я только родился"),
            Publication(photo: remySleep, text: "Хочу поспать"),
            Publication(photo: remySleeping, text: "Это я уже сплю"),
            Publication(photo: remyWash, text: "Я помылся"),
            Publication(photo: remyEat, text: "Тут я ем"),
            Publication(photo: remy, text: "Добро пожаловать на мой аккаунт")
        ]
    }

    private var publications: [Publication] = []
    let semaphore = DispatchSemaphore(value: 1)

    func syncSavePublication(_ publication: Publication) {
        publications.append(publication)
    }

    func asyncSavePublication(_ publication: Publication) {

        let operationQueue = OperationQueue()

        let saveOperation = BlockOperation { [weak self] in
            self?.semaphore.wait()
            self?.publications.append(publication)
            self?.semaphore.signal()
        }

        saveOperation.completionBlock = {
            print("Публикация успешно сохранена")
        }

        operationQueue.addOperation(saveOperation)
    }

    func syncGetPublication(byId id: UUID) -> Publication? {

        return publications.first { $0.id == id }
    }

    func asyncGetPublication(byId id: UUID) -> Publication? {

        var result: Publication?
        let operationQueue = OperationQueue()

        let getOperation = BlockOperation { [weak self] in
            self?.semaphore.wait()
            result = self?.syncGetPublication(byId: id)
            self?.semaphore.signal()
        }

        getOperation.completionBlock = {
            if result != nil {
                print("Нашелся пользователь с таким Id")
            } else {
                print("Пользователя с таким Id нет")
            }
        }

        operationQueue.addOperation(getOperation)
        return result
    }

    func syncDeletePublication(byId id: UUID) {

        let index = publications.firstIndex { $0.id == id }
        if let index {
            publications.remove(at: index)
        }
    }

    func asyncDeletePublication(byId id: UUID) {

        let operationQueue = OperationQueue()

        let deleteOperation = BlockOperation { [weak self] in
            self?.semaphore.wait()
            self?.syncDeletePublication(byId: id)
            self?.semaphore.signal()
        }

        deleteOperation.completionBlock = {
            print("Пользователь с таким Id удален, если он был")
        }

        operationQueue.addOperation(deleteOperation)
    }

    func syncGetAllPublications() -> [Publication] {
        return publications
    }

    func asyncGetAllPublications() -> [Publication] {

        let operationQueue = OperationQueue()
        var result: [Publication] = []

        let operation = BlockOperation { [weak self] in
            self?.semaphore.wait()
            result = self?.syncGetAllPublications() ?? []
            self?.semaphore.signal()
        }

        operation.completionBlock = {
            print("Все публикации успешно получены")
        }

        operationQueue.addOperation(operation)
        semaphore.wait()
        semaphore.signal()

        return result
    }

    func syncDeletePublication(withIndex index: Int) {
        publications.remove(at: index)
    }

    func asyncDeletePublication(withIndex index: Int) {

        let operationQueue = OperationQueue()

        let operation = BlockOperation { [weak self] in
            self?.publications.remove(at: index)
        }

        operation.completionBlock = {
            print("Публикация удалена")
        }

        operationQueue.addOperation(operation)
    }
}
