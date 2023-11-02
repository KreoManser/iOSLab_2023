//
//  Manager.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 30.10.2023.
//

import Foundation
import UIKit
protocol ManagerDelegate: AnyObject {
    func updateData()
}
protocol OperationWithPublisher: AnyObject {
    static func syncGetPublisher(_: Publisher)
    static func syncDelete(_: Publisher)
    static func syncFind(id: String) -> Publisher
    static func syncSave(id: String)
    static func asyncGetPublisher(completion: @escaping ([Publisher]) -> Void)
    static func asyncDelete(_ publisher: Publisher, completion: @escaping (Array<Publisher>.Index, Bool) -> Void)
    static func asyncFind(withCriteria id: String, completion: @escaping (Publisher?) -> Void)
    static func asyncSave(_ publisher: Publisher, completion: @escaping (Bool) -> Void)
}
class DataManager: OperationWithPublisher {
    weak var delegate: ManagerDelegate?
    private static let saveQueue = OperationQueue()
    private static let getQueue = OperationQueue()
    private static let searchQueue = OperationQueue()
    private static let deleteQueue = OperationQueue()
    static let shared = DataManager()
    private init () {
    }
    static var publishers: [Publisher] = [
        Publisher(id: "1", description: "Description 1", date: "4 июня", image: UIImage(named: "photo1")),
        Publisher(id: "2", description: "Description 2", date: "21 августа", image: UIImage(named: "photo2")),
        Publisher(id: "3", description: "Description 3", date: "20 июля", image: UIImage(named: "photo3"))
    ] {
        didSet {
            DataManager.shared.delegate?.updateData()
        }
    }
    static func getPublishers() -> [Publisher] {
        let newPublishers = publishers
        return newPublishers
    }
    static func getPublishers(completion: @escaping ([Publisher]) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(self.publishers)
        }
    }
    static func asyncGetPublisher(completion: @escaping ([Publisher]) -> Void) {
        DataManager.getQueue.addOperation {
            let result = DataManager.publishers
            completion(result)
        }
    }
    static func asyncDelete(_ publisher: Publisher, completion: @escaping (Array<Publisher>.Index, Bool) -> Void) {
        DataManager.deleteQueue.addOperation {
            DispatchQueue.main.async {
                if let objectIndex = DataManager.publishers.firstIndex(where: { $0.id == publisher.id }) {
                    DataManager.publishers.remove(at: objectIndex)
                    let result = !DataManager.publishers.contains(publisher)
                    completion(objectIndex, result)
                }
            }
        }
    }
    static func asyncFind(withCriteria id: String, completion: @escaping (Publisher?) -> Void) {
        DataManager.searchQueue.addOperation {
            if let objectIndex = DataManager.publishers.firstIndex(where: { $0.id == id }) {
                let foundPublisher = DataManager.publishers[objectIndex]
                completion(foundPublisher)
            } else {
                completion(nil)
            }
        }
    }
    static func asyncSave(_ publisher: Publisher, completion: @escaping (Bool) -> Void) {
        DataManager.saveQueue.addOperation {
            if !DataManager.publishers.contains(publisher) {
                DataManager.publishers.append(publisher)
            }
            let result = DataManager.publishers.contains(publisher)
            completion(result)
        }
    }
    static func syncFind(id: String) -> Publisher {
        //
        return DataManager.publishers[0]
    }
    static func syncSave(id: String) {
        //
    }
    static func syncGetPublisher(_: Publisher) {
    }
    static func syncDelete(_: Publisher) {
        //
    }
}
