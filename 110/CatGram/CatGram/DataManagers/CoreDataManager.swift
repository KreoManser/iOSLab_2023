import Foundation
import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private init() { }

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CatGramCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

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

    func createUser(login: String, password: String, username: String, avatar: UIImage, description: String) -> User {
        let user = User(context: viewContext)
        user.id = UUID()
        user.login = login
        user.password = password
        user.username = username
        user.accountDescription = description
        if let image = avatar.pngData() {
            user.profileImage = image
        }
        return user
    }

    func signUpUser(login: String, password: String, username: String, avatar: UIImage, description: String) {
        let user = User(context: viewContext)
        user.id = UUID()
        user.login = login
        user.password = password
        user.username = username
        user.accountDescription = description
        if let image = avatar.pngData() {
            user.profileImage = image
        }
        saveContext()
    }

// инициализация первоначальных юзеров
    func initUsers() -> [User] {
        var users = [User] ()
        if let image1 = UIImage(named: "msCat") {
            let user1 = createUser(login: "misskitty", password: "1111", username: "misskitty", avatar: image1, description: "whiskas is top")
            users.append(user1)
        }
        if let image2 = UIImage(named: "kingcat") {
            let user2 = createUser(login: "kingcat", password: "1234", username: "kingcat", avatar: image2, description: "where is my throne")
            users.append(user2)
        }
        if let image3 = UIImage(named: "funnyCat") {
            let user3 = createUser(login: "funnyCat", password: "1212", username: "funnyCat", avatar: image3, description: "the best thing is bed")
            users.append(user3)
        }

        return users
    }
// получение всех юзеров
    func obtainSavedUsers() -> [User] {

        let userFetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]

        let result = try? viewContext.fetch(userFetchRequest)

        return result ?? []
    }

}
