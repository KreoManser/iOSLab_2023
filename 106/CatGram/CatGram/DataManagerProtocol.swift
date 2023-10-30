import Foundation

protocol DataManagerProtocol {

    func syncSave(post: Post)
    func asyncSave(post: Post, completion: @escaping (Bool) -> Void)

    func syncGetPosts() -> [Post]
    func asyncGetPosts(completion: @escaping ([Post]) -> Void)

    func syncDelete(post: Post)
    func asyncDelete(post: Post, completion: @escaping (Bool) -> Void)

    func syncSearchPostById(byId id: Int) -> Post?
    func asyncSearchPostById(byId id: Int, completion: @escaping (Post?) -> Void)

}
