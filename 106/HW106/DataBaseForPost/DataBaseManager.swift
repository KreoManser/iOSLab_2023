//
//  DataBaseManager.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 30.01.2024.
//

import Foundation
import UIKit
protocol DataProtocol {
    func syncSave(model: Model)
    func asyncSave(model: Model, completion: @escaping (Bool) -> Void)
    func syncGetModel() -> [Model]
    func asyncGetModel(completion: @escaping ([Model]) -> Void)
    func syncRemoveModel(at index: Int)
    func asyncRemoveModel(at index: Int, completion: @escaping (Bool) -> Void)
    func syncSearchModel(byName login: String) -> Model?
    func asyncSearchModel(byName login: String, completion: @escaping (Model?) -> Void)
    func syncSearchModel(byId id: Int) -> Model?
    func asyncSearchModel(byId id: Int, completion: @escaping (Model?) -> Void)
}

class DataBaseManager: DataProtocol {

    static let shared = DataBaseManager()
    
    private let queue = OperationQueue()
    private let syncQueue = DispatchQueue(label: "com.example.syncQueue", attributes: .concurrent)
    private let dataSemaphore = DispatchSemaphore(value: 1)
    
    
     var dataSource: [Model] = [
        Model(id: "0", login: "b.o.o.m.b.a.s.t.i.c", inscription: "Самый красивый котэ", date: "03-12-23", avatarImageView: UIImage(named: "котик")),
        Model(id: "1", login: "asb", inscription: "Сомнительно, ноо окээй", date: "01-01-24", avatarImageView: UIImage(named: "котик1")),
        Model(id: "2", login: "b.o.o.m.b.a.s.t.i.c", inscription: "Котик мой", date: "07-01-24", avatarImageView: UIImage(named: "котик2")),
        Model(id: "3", login: "b.o.o.m.b.a.s.t.i.c", inscription: "Котик Подруги", date: "09-01-24", avatarImageView: UIImage(named: "котик3")),
        Model(id: "4", login: "b.o.o.m.b.a.s.t.i.c", inscription: "Самый красивый котэ", date: "15-01-24", avatarImageView: UIImage(named: "котик")),
        Model(id: "5", login: "Gosha555", inscription: "Сомнительно, ноо окээй", date: "24-01-24", avatarImageView: UIImage(named: "котик1")),
        Model(id: "6", login: "asb", inscription: "Котик мой", date: "01-02-24", avatarImageView: UIImage(named: "котик2")),
        Model(id: "6", login: "Gosha555", inscription: "Котик Подруги", date: "08-02-24", avatarImageView: UIImage(named: "котик3")),
    ]
    
    func syncSave(model: Model) {
        dataSemaphore.wait()
        
        syncQueue.sync {
            dataSource.append(model)
        }
        
        dataSemaphore.signal()
    }
    
    func asyncSave(model: Model, completion: @escaping (Bool) -> Void) {
        let saveOperation = BlockOperation {
            self.dataSemaphore.wait()
            self.syncQueue.sync {
                self.dataSource.append(model)
            }
        }
        self.dataSemaphore.signal()
        saveOperation.completionBlock = {
            completion(true)
        }
        
        queue.addOperation(saveOperation)
    }

    func syncGetModel() -> [Model] {
        dataSemaphore.wait()
        // здесь без defer никак, так как есть return
        defer {
            dataSemaphore.signal()
        }
        
        return syncQueue.sync {
            dataSource
        }
    }

    func asyncGetModel(completion: @escaping ([Model]) -> Void) {
        let getModelOperation = BlockOperation {
            self.dataSemaphore.wait()
            let models = self.syncQueue.sync {
                self.dataSource
            }
            
            self.dataSemaphore.signal()
            completion(models)
        }
        
        queue.addOperation(getModelOperation)
    }

    func syncRemoveModel(at index: Int) {
        dataSemaphore.wait()
        
        syncQueue.sync {
            dataSource.remove(at: index)
        }
        
        dataSemaphore.signal()
    }

    func asyncRemoveModel(at index: Int, completion: @escaping (Bool) -> Void) {
        let removeOperation = BlockOperation {
            self.dataSemaphore.wait()
            self.syncQueue.sync {
                if index < self.dataSource.count {
                    self.dataSource.remove(at: index)
                    self.dataSemaphore.signal()
                    completion(true)
                } else {
                    self.dataSemaphore.signal()
                    completion(false)
                }
            }
        }
        
        queue.addOperation(removeOperation)
    }

    func syncSearchModel(byName login: String) -> Model? {
        dataSemaphore.wait()
        // здесь без defer никак, так как есть return
        defer {
            dataSemaphore.signal()
        }
        
        return syncQueue.sync {
            dataSource.first(where: { $0.login == login })
        }
    }

    func asyncSearchModel(byName login: String, completion: @escaping (Model?) -> Void) {
        let searchOperation = BlockOperation {
            self.dataSemaphore.wait()
            let model = self.syncQueue.sync {
                self.dataSource.first(where: { $0.login == login })
            }
            self.dataSemaphore.signal()
            completion(model)
        }
        
        queue.addOperation(searchOperation)
    }

    func syncSearchModel(byId id: Int) -> Model? {
        dataSemaphore.wait()
        // здесь без defer никак, так как есть return
        defer {
            dataSemaphore.signal()
        }

        return syncQueue.sync {
            dataSource.first(where: { $0.id == "\(id)" })
        }
    }

    func asyncSearchModel(byId id: Int, completion: @escaping (Model?) -> Void) {
        let searchOperation = BlockOperation {
            self.dataSemaphore.wait()
            
            let model = self.syncQueue.sync {
                self.dataSource.first(where: { $0.id == "\(id)" })
            }
            self.dataSemaphore.signal()
            completion(model)
        }
    
        queue.addOperation(searchOperation)
    }
}
