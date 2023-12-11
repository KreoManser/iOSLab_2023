import Foundation

protocol DataManagerProtocol {

    func syncGetUsers() -> [User]
    func asyncGetUsers() async -> [User]

    func syncSave(post: Post)
    func asyncSave(post: Post) async -> Bool
//    func asyncSave(post: Post, completion: @escaping (Bool) -> Void)

    func syncGetPosts() -> [Post]
    func asyncGetPosts() async -> [Post]
//    func asyncGetPosts(completion: @escaping ([Post]) -> Void)

    func syncDelete(post: Post)
    func asyncDelete(post: Post) async -> Bool
//    func asyncDelete(post: Post, completion: @escaping (Bool) -> Void)

    func syncSearchPostById(byId id: Int) -> Post?
    func asyncSearchPostById(byId id: Int) async -> Post?
//    func asyncSearchPostById(byId id: Int, completion: @escaping (Post?) -> Void)

}
