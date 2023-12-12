//
//  CoreDataManager.swift
//  CaTGramm
//
//  Created by Rustem on 11.12.2023.
//

import Foundation
import CoreData

class CoreDataManager {

    public static let shared = CoreDataManager()

    private init() { }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
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

    func obtainSavedUsers () -> [User] {
        let userFetchRequest = User.fetchRequest()
        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }
}
