//
//  StorageManager.swift
//  HW106
//
//  Created by Ильмир Шарафутдинов on 07.02.2024.
//

import Foundation
import CoreData
import UIKit

public final class StorageManager: NSObject {
    public static let shared = StorageManager ()
    private override init() {}
    
    
    // MARK: - Core Data stack
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HW106")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainSavedData() -> [UserRegistration] {
        let userFetchRequest = UserRegistration.fetchRequest()
        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }
    
    func delete(_ post: Post) throws {
        viewContext.delete(post)
        if viewContext.hasChanges {
            try viewContext.save ()
        }
    }
}
