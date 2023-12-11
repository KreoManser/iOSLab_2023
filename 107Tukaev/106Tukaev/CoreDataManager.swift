//  CoreDataManager.swift
//  TestCoreDataProject
//
//  Created by Ildar Zalyalov on 2023-12-03.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    var obtainUsers: [User] = []
    var authUser: User?

    private init() {}

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
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

    func createUser(login: String, pass: String, name: String) -> User {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.login = login
        newUser.password = pass
        newUser.name = name
        newUser.image = "user"
        return newUser
    }

    func regisUser(login: String, pass: String, name: String) {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.login = login
        newUser.password = pass
        newUser.name = name
        newUser.image = "user"
        saveContext()
    }

    private func createDate( year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar.current
        var date = Date()
        if let dateCalendar = calendar.date(from: DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)) {
            date = dateCalendar
        }
        return date
    }

    func createPubl(description: String) -> Publication {
        let newPubl = Publication(context: viewContext)
        newPubl.id = UUID()
        newPubl.date = Date()
        newPubl.discription = description
        return newPubl
    }

    func createImage(nameImage: String) -> Image {
        let newImage = Image(context: viewContext)
        newImage.nameImage = nameImage
        return newImage
    }

    func createLike(user: User) -> Like {
        let like = Like(context: viewContext)
        like.user = user
        return like
    }

    func obtainDefaultData() -> [User] {
        var users: [User] = []

        let image1 = createImage(nameImage: "user")
        let image2 = createImage(nameImage: "Cat")
        let image3 = createImage(nameImage: "Cat")
        let publ1 = createPubl(description: "1")
        publ1.addToImages(image1)
        let publ2 = createPubl(description: "2")
        publ2.addToImages(image2)
        let publ3 = createPubl(description: "3")
        publ3.addToImages(image3)

        let user1 = createUser(login: "admin1", pass: "123", name: "Aidar")
        let user2 = createUser(login: "admin2", pass: "123", name: "Alina")
        let user3 = createUser(login: "admin3", pass: "123", name: "Artur")
        user1.addToPublications(publ1)
        user1.addToPublications(publ2)
        user2.addToPublications(publ3)
        user1.addToSubscription(user2)
        user2.addToSubscribers(user1)

        users.append(user1)
        users.append(user2)
        users.append(user3)
        return users
    }

    func subscribeToUser(toUser: User) {
        if (authUser?.subscription.contains(where: { $0.login == toUser.login })) == true {
            authUser?.removeFromSubscription(toUser)
        } else {
            authUser?.addToSubscription(toUser)
        }
        updateSelfUser()
    }

    func obtainSavedData() -> [User] {
        let userFetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]

        let result = try? viewContext.fetch(userFetchRequest)

        if let authUser = authUser {
            self.authUser = result?.first(where: { $0.login == authUser.login })
        }
        return result ?? []
    }

    func deleteUser(_ user: User) throws {

        viewContext.delete(user)
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }

    func deletePubl(_ publId: UUID) throws {
        if let user = obtainSavedData().first(where: { $0.publications.contains { $0.id == publId } }) {
            if let publToDelete = user.publications.first(where: { $0.id == publId }) {
                viewContext.delete(publToDelete)
                if viewContext.hasChanges {
                    try viewContext.save()
                }
            }
        }
    }

    func likeTap(publ: Publication) -> Bool {

        if publ.likes.contains(where: { $0.user == self.authUser }) {
            return false
        } else {
            return true
        }
    }

    func searchUser(searchPrefix: String) -> [User] {
        let users = obtainSavedData().filter { $0.login.lowercased().hasPrefix(searchPrefix.lowercased()) && $0 != self.authUser }
        return users
    }

    func addLike(publ: Publication) -> Bool {

        if let like = publ.likes.first(where: { $0.user == self.authUser }) {
            publ.removeFromLikes(like)
            updateSelfUser()
            return false
        } else {
            let like = createLike(user: authUser ?? User())
            publ.addToLikes(like)
            updateSelfUser()
            return true
        }
    }

    func getSelfPublSubscription() -> [Publication] {
        var publications: [Publication] = []
        authUser?.subscription.forEach { subUser in
            publications.append(contentsOf: subUser.publications)
        }
        publications.sort { $0.date < $1.date }

        return publications
    }
    func getPublSubscription(user: User) -> [Publication] {
        var publications: [Publication] = []
        let userIn = obtainSavedData().first(where: { $0.login == user.login })
        userIn?.subscription.forEach { subUser in
            publications.append(contentsOf: subUser.publications)
        }
        publications.sort { $0.date < $1.date }

        return publications
    }

    func getUserPubl(user: User) -> [Publication] {
        var publications: [Publication] = []
        obtainSavedData().forEach({ userIn in
            if userIn.login == user.login {
                publications.append(contentsOf: user.publications)
            }
        })
        publications.sort { $0.date < $1.date }

        return publications
    }

    func getAllPubl() -> [Publication] {
        var publications: [Publication] = []
        obtainSavedData().forEach({ user in
            publications.append(contentsOf: user.publications)
        })
        publications.sort { $0.date < $1.date }

        return publications
    }

    func authCheck(login: String, pass: String) -> Bool {
        let data: [User]

        if !obtainSavedData().isEmpty {
            data = obtainSavedData()
        } else {
            data = obtainDefaultData()
        }
        authUser = data.first(where: { $0.login == login && $0.password == pass})
        if authUser != nil {
            return true
        }
        return false
    }

    func checkUser(login: String, pass: String, name: String) -> Bool {
        if obtainSavedData().contains(where: { $0.login == login }) {
            return true
        }
        regisUser(login: login, pass: pass, name: name)
        return false
    }
    func getUserByLogin(login: String) -> User? {
        if let user = obtainSavedData().first(where: { $0.login == login }) {
            return user
        }
        return nil
    }

    func getSelfPubl() -> [Publication] {
        updateSelfUser()
        var publications: [Publication] = []
        authUser?.publications.forEach({ publ in
            publications.append(publ)
        })
        publications.sort { $0.date < $1.date }
        return publications
    }

    func exitUser() {
        authUser = nil
    }

    func updateSelfUser() {
        authUser = obtainSavedData().first(where: { $0.login == authUser?.login })
        saveContext()
    }
}
