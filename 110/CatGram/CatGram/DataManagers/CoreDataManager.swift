import Foundation
import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    //    private var dataManager = DataManager()

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
    func getCurrentUser() -> User? {
        let users = obtainSavedUsers()
        guard let login = UserDefaults.standard.string(forKey: "saved_users") else { return nil }
        return users.first(where: { $0.login == login })
    }
    // user methods
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
    func initUsers() {
        var users = [User] ()
        if let image1 = UIImage(named: "msCat") {
            let user1 = createUser(login: "misskitty", password: "1111", username: "misskitty", avatar: image1, description: "whiskas is top")
            users.append(user1)
        }
        if let image2 = UIImage(named: "kingCat") {
            let user2 = createUser(login: "kingcat", password: "1234", username: "kingcat", avatar: image2, description: "where is my throne")
            users.append(user2)
        }
        if let image3 = UIImage(named: "funnyCat") {
            let user3 = createUser(login: "funnycat", password: "1212", username: "funnycat", avatar: image3, description: "the best thing is bed")
            users.append(user3)
        }
        saveContext()
        //        return users  -> [User]
    }
    // получение всех юзеров
    func obtainSavedUsers() -> [User] {

        let userFetchRequest = User.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "login", ascending: true)
        //        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        userFetchRequest.sortDescriptors = [sortDescriptor]

        let result = try? viewContext.fetch(userFetchRequest)

        return result ?? []
    }
    func deleteUser(user: User) {
        viewContext.delete(user)
        saveContext()
    }
    func deleteAllSavedUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    // post methods
    func createPostForCurrentUser(caption: String, image: UIImage) {
        let post = Post(context: viewContext)
        let user = getCurrentUser()
        post.user = user
        post.id = UUID()
        post.caption = caption
        post.date = Date()
        if let image = image.pngData() {
            post.image = image
        }
        post.countOfLikes = 0
        //        прикрепляем пост к пользователю (добавляем в массив пользователя)
        user?.addToPosts(post)
        saveContext()
    }
    func getCurrentUserPosts() -> [Post] {
        getCurrentUser()?.posts?.allObjects as? [Post] ?? []
    }
    func getAllSavedPosts() -> [Post] {
        let userFetchRequest = Post.fetchRequest()

        let result = try? viewContext.fetch(userFetchRequest)
        return result ?? []
    }
    func getPostById(id: UUID) -> Post? {
        return getAllSavedPosts().first(where: { $0.id == id })
    }
    func updatePostById(id: UUID, newCaption: String) {
        let post = getPostById(id: id)
        post?.caption = newCaption
        saveContext()
    }
    func deletePostById(id: UUID) {
        guard let post = getPostById(id: id) else { return }
        getCurrentUser()?.removeFromPosts(getPostById(id: id) ?? Post())
        //        dataManager.obtainUserByLogin()?.removeFromPosts(post ?? Post())
        viewContext.delete(post)
        saveContext()
    }
    func deleteAllSavedPosts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Post")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    func createPost(caption: String, date: Date, user: User, countOfLike: Int, image: UIImage) {
        let post = Post(context: viewContext)
        post.id = UUID()
        post.caption = caption
        post.user = user
        if let postImage = image.pngData() {
            post.image = postImage
        }
        post.countOfLikes = countOfLike
        post.date = date
        user.addToPosts(post)

        saveContext()
        //        return post  -> Post
    }
//    инициализация первоначальных постов
    func initPosts() {
        let users = obtainSavedUsers()

        let post1 = Post(context: viewContext)
        post1.id = UUID()
        post1.caption = "The mini Cat"
        post1.date = Date()
        let user1 = users.first(where: { $0.login == "misskitty" })
        post1.user = user1
        post1.countOfLikes = 5
        if let image1 = UIImage(named: "miniCat") {
            if let postImage = image1.pngData() {
                post1.image = postImage
            }
        }
        user1?.addToPosts(post1)


        let post2 = Post(context: viewContext)
        post2.id = UUID()
        post2.caption = "Mr Cat"
        post2.date = Date()
        post2.user = users.first(where: { $0.login == "kingcat" })
        post2.countOfLikes = 7
        if let image2 = UIImage(named: "mrCat") {
            if let postImage = image2.pngData() {
                post2.image = postImage
            }
        }

        let post3 = Post(context: viewContext)
        post3.id = UUID()
        post3.caption = "With bro"
        post3.date = Date()
        post3.user = users.first(where: { $0.login == "funnycat" })
        post3.countOfLikes = 11
        if let image3 = UIImage(named: "3in1Cats") {
            if let postImage = image3.pngData() {
                post3.image = postImage
            }
        }

        saveContext()
    }
}


//        if let user1 = users.first(where: { $0.login == "misskitty" }) {
//            if let image1 = UIImage(named: "miniCat") {
//                createPost(caption: "The mini Cat", date: Date(), user: user1, countOfLike: 5, image: image1)
////                user1.addToPosts(post1)
//            }
//        }
//        if let user2 = users.first(where: { $0.login == "kingcat" }) {
//            if let image1 = UIImage(named: "mrCat") {
//                createPost(caption: "Mr Cat", date: Date(), user: user2, countOfLike: 7, image: image1)
//            }
//        }
//        if let user3 = users.first(where: { $0.login == "funnycat" }) {
//            if let image1 = UIImage(named: "3in1Cats") {
//                createPost(caption: "With bro", date: Date(), user: user3, countOfLike: 11, image: image1)
//            }
//        }

