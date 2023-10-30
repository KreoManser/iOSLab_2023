import Foundation
import UIKit

protocol OperationWithPublisher: AnyObject {
    static func syncGetPublisher(_ : Publisher)
    static func syncDelete(_ : Publisher)
    static func syncFind(id: String) -> Publisher
    static func syncSave(id: String)
    
    static func asyncGetPublisher(completion: @escaping ([Publisher]) -> Void)
    static func asyncDelete(_ publisher: Publisher, completion: @escaping (Bool) -> Void)
    static func asyncFind(withCriteria id: String, completion: @escaping (Publisher?) -> Void)
    static func asyncSave(_ publisher: Publisher, completion: @escaping (Bool) -> Void)
}

class Manager: OperationWithPublisher {
    private static let saveQueue = OperationQueue()
    private static let getQueue = OperationQueue()
    private static let searchQueue = OperationQueue()
    private static let deleteQueue = OperationQueue()
    
    static let shared = Manager()
    private init () {}
    
    static var publishers: [Publisher] = [
        Publisher(id: "1", description: "Description 1", date: "4 июня", image: UIImage(named: "photo1")),
        Publisher(id: "2", description: "Description 2", date: "21 августа", image: UIImage(named: "photo2")),
        Publisher(id: "3", description: "Description 3", date: "20 июля", image: UIImage(named: "photo3")),
    ]
    
    static func asyncGetPublisher(completion: @escaping ([Publisher]) -> Void) {
        Manager.getQueue.addOperation {
            let result = Manager.publishers
            completion(result)
        }
    }

    static func asyncDelete(_ publisher: Publisher, completion: @escaping (Bool) -> Void) {
        Manager.deleteQueue.addOperation {
            // В этом блоке происходит асинхронное удаление публикации
            if let objectIndex = Manager.publishers.firstIndex(where: { $0.id == publisher.id }) {
                print(objectIndex)
                Manager.publishers.remove(at: objectIndex)
            }
            
            let result = !Manager.publishers.contains(publisher)
            completion(result)
        }
    }
    static func asyncFind(withCriteria id: String, completion: @escaping (Publisher?) -> Void) {
        Manager.searchQueue.addOperation {
            // В этом блоке происходит асинхронный поиск публикации
            if let objectIndex = Manager.publishers.firstIndex(where: { $0.id == id }) {
                let foundPublisher = Manager.publishers[objectIndex]
                completion(foundPublisher)
            }
            else {
                completion(nil)
            }
        }
    }
   
    static func asyncSave(_ publisher: Publisher, completion: @escaping (Bool) -> Void) {
        Manager.saveQueue.addOperation {
        if !Manager.publishers.contains(publisher) {
            Manager.publishers.append(publisher)
        }

        let result = Manager.publishers.contains(publisher)
        completion(result)
        }
    }
    
    static func syncFind(id: String) -> Publisher {
        //
        return Manager.publishers[0]
    }
    
    static func syncSave(id: String) {
        //
    }
    
    static func syncGetPublisher(_: Publisher) {
        //
    }
    
    static func syncDelete(_: Publisher) {
        //
    }


}


