//
//  NewsManager.swift
//  CatGram
//
//  Created by Mac on 2023-11-05.
//

import UIKit

protocol NewsManagerProtocol {
    func createNewsForUserAsync(user: User)
    func deletePostFromNewsAsync(index: Int)
}

class NewsManager: NewsManagerProtocol {
    private let support = SupportFunctions()
    private lazy var userManager = UserManager.userManager
    weak var delegate: UpdateUserProtocol?
    var posts: [Post] = []
    private var personalPosts: [Post] = []
    private var personalPostsForNews: [Post] = []
    private let userDefaults = UserDefaults.standard
    private let newsKey = "save_news"
    private let userKey = "log_user"

    static let newsManager = NewsManager()

    private let createPostsQueue = OperationQueue()
    private let deletePostQueue = OperationQueue()
    private let likePostQueue = OperationQueue()

    init() {
        PostsManager.postsManager.delegateNews = self
    }

    func createNewsForUserAsync(user: User) {
        if userDefaults.bool(forKey: "is_log_user") && !getNews().isEmpty {
            var count = self.userManager.users.count - 1
            let news = getNews()
            let user = self.userManager.loginedUser ?? User()
            posts = news

            while count != 0 {
                for randomUser in self.userManager.users {
                    if randomUser.nick == user.nick {
                        self.checkPersonalPosts(randomUser)
                        count = 0
                        break
                    }
                    count -= 1
                }
            }
        } else {
            let operation = BlockOperation {
                var count = self.userManager.users.count - 1
                self.posts = []
                while self.posts.isEmpty {
                    let randomNumber = Int.random(in: 0...count)
                    let randomUser = self.userManager.users[randomNumber]
                    if randomUser.nick != user.nick {
                        self.checkGeneralPosts(randomUser)
                    }
                }
                while count != 0 {
                    for randomUser in self.userManager.users {
                        if randomUser.nick == user.nick {
                            self.checkPersonalPosts(randomUser)
                            self.posts += self.personalPostsForNews
                            count = 0
                            break
                        }
                        count -= 1
                    }
                }
                self.saveNews(posts: self.posts)
            }
            operation.completionBlock = {
                print("посты для юзера \(user.nick) done асинк")
            }
            createPostsQueue.addOperation(operation)
        }
    }

    func deletePostFromNewsAsync(index: Int) {
        let operation = BlockOperation {
            let post = self.posts[index]
            guard let personalIndex = self.personalPosts.firstIndex(of: post) else { return }
            guard let personalForNews = self.personalPostsForNews.firstIndex(of: post) else { return }
            if post.nick == self.userManager.loginedUser?.nick {
                self.personalPosts.remove(at: personalIndex)
                self.posts.remove(at: index)
                self.personalPostsForNews.remove(at: personalForNews)
                self.delegate?.updateUser(posts: self.personalPosts)
                self.saveNews(posts: self.posts)
            }
        }
        operation.completionBlock = {
            print("пост по индексу \(index) delete асинк")
        }
        deletePostQueue.addOperation(operation)
    }

    func likePostAsync(_ index: Int) {
        let operation = BlockOperation {
            let post = self.posts[index]
            let updatePersonal = self.personalPosts
            if post.isLike {
                self.posts[index].isLike = false
                self.posts[index].amountOfLikes -= 1
                updatePersonal[self.personalPosts.firstIndex(of: post) ?? 0].isLike = false
                updatePersonal[self.personalPosts.firstIndex(of: post) ?? 0].amountOfLikes -= 1
            } else {
                self.posts[index].isLike = true
                self.posts[index].amountOfLikes += 1
                updatePersonal[self.personalPosts.firstIndex(of: post) ?? 0].isLike = true
                updatePersonal[self.personalPosts.firstIndex(of: post) ?? 0].amountOfLikes += 1
            }

            self.delegate?.updateLike(posts: updatePersonal)
            self.saveNews(posts: self.posts)
        }
        operation.completionBlock = {
            print("у поста по индексу \(index) изменён лайк асинк")
        }
        likePostQueue.addOperation(operation)
    }
}

extension NewsManager: UpdateNewsProtocol {
    func updateNews(posts: [Post]) {
        var postsForNews: [Post] = []
        for post in posts where post.isNew {
            postsForNews.append(post)
        }
        self.posts.removeAll { personalPostsForNews.contains($0) }
        self.personalPostsForNews = postsForNews
        self.posts += personalPostsForNews
        saveNews(posts: self.posts)
    }
}

extension NewsManager {
    private func checkPersonalPosts(_ randomUser: User) {
        for post in randomUser.posts {
            personalPosts.append(post)
            if post.isNew {
                personalPostsForNews.append(post)
            }
        }
    }
    private func checkGeneralPosts(_ randomUser: User) {
        for post in randomUser.posts where post.isNew {
            posts.append(post)
        }
    }

    private func saveNews(posts: [Post]) {
        let encoder = JSONEncoder()
        let userData = try? encoder.encode(posts)
        userDefaults.setValue(userData, forKey: newsKey)
    }
    private func getNews() -> [Post] {
        guard let postsData = userDefaults.data(forKey: newsKey) else { return [] }

        do {
            let decoder = JSONDecoder()
            let posts = try decoder.decode([Post].self, from: postsData)
            return posts
        } catch {
            print("fail in decode \(error)")
        }
        return []
    }
}
