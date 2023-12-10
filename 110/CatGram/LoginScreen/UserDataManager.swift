//
//  LoginUserDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 03.11.2023.
//

import Foundation

class UserDataManager: NSObject, UserManaging {

    static let shared = UserDataManager()
    var feedDataManager: FeedDataManager?
    var coreDataManager: CoreDataManager?

//    var users: [User] = [User(username: "Doosuur14", password: "456",
//                              interest: "Fashion", friends: ["Lovelycats__", "User1"]), User(username: "Lovelycats__", password: "123",
//                                                                                             interest: "Animals", friends: ["Doosuur14"]),
//                         User(username: "User1", password: "1234",
//                              interest: "Nature", friends: ["Doosuur14", "Lovelycats__"])
//    ]

    let userdefaults = UserDefaults.standard
    var didTapLoginButton: (() -> Void)?

    override init() {
        super.init()
       
//        if !users.isEmpty {
//            print(users)
//        }
    }

    func asyncRegisterUser(username: String, password: String, interest: String, email: String,
                           completion: @escaping (Result<User, UserError>) -> Void) {
        Task {
            do {
                print("async register is called")
                try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
                guard let context = coreDataManager?.viewContext else {
                    print("Context absent")
                    completion(.failure(UserError.registrationFailed))
                    return
            }
                print("context available")
                let fetchRequest = User.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "username == %@", username)
                let existingUsers = try context.fetch(fetchRequest)
                if !existingUsers.isEmpty {
                    completion(.failure(UserError.usernameTaken))
                    return
                }
                let newUser = User(context: context)
                newUser.username = username
                newUser.password = password
                newUser.interest = interest
                newUser.email = email
                
                try context.save()
                print("registration process successful")
                completion(.success(newUser))

            } catch {
                print("registration process failed: \(error)")
                completion(.failure(UserError.registrationFailed))
            }
        }
    }

    func asyncLogin(username: String, password: String, completion: @escaping (Result<User, UserError>) -> Void) {
        Task {
            do {
                guard let context = coreDataManager?.viewContext else {
                           print("Context absent")
                           return
                }
                let fetchRequest = User.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    completion(.success(user))
                    saveUser(user)
                } else {
                    completion(.failure(UserError.userNotFound))
                }
            } catch {
                print("login failed")
                completion(.failure(.loginFailed))
            }
        }
    }
    
//    func asynRetrieveUser(username: String, completinon: @escaping (Result<User, UserError>) -> Void) {
//        Task {
//            do {
//                try await Task.sleep(nanoseconds: 1 * 1000_000_000)
//                let user = users.first(where: { $0.username == username})
//                completinon(.success(user!))
//            } catch {
//                completinon(.failure(UserError.userNotFound))
//            }
//        }
//    }

    func authenticateUser(username: String, password: String, completion: @escaping (Result<User, UserError>) -> Void) {
        Task {
            do {
                guard let context = coreDataManager?.viewContext else {
                           print("Context absent")
                           return
                }
                let fetchRequest = User.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
                let users = try context.fetch(fetchRequest)
                if let user = users.first {
                    completion(.success(user))
                    saveUser(user)
                } else {
                    completion(.failure(UserError.userNotFound))
                }
            } catch {
                print("login failed")
                completion(.failure(.loginFailed))
            }
        }

    }


    func saveUser(_ user: User) {
        guard let context = coreDataManager?.viewContext else {
            print("Context absent")
            return
        }
        do {
            try context.save()
            userdefaults.set(true, forKey: Keys.isUserLoggedIn)
            print("user saved to core data")
        }catch{
            print("")
        }
    }

    func loadUser() -> User? {
        guard let context = coreDataManager?.viewContext else {
            print("Context absent")
            return nil
        }
        do {
            let fetchUser = User.fetchRequest()
            let users = try context.fetch(fetchUser)
            if let users = users.first {
                print("Users loaded from core data")
                return users
            } else {
                return nil
            }
        } catch {
            print("Error while loading users from core data")
            return nil
        }
    }
}
