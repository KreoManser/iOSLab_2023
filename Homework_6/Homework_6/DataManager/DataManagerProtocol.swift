import Foundation

protocol DataManagerProtocol {
    func syncSave(_ model: Post)
    func syncDelete(_ model: Post)
    func syncGetAllPosts() -> [Post]
    func syncSearchPosts(by caption: String) -> [Post]

    func asyncSave(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void)
    func asyncDelete(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void)
    func asyncGetAllPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func asyncSearchPosts(by caption: String, completion: @escaping (Result<[Post], Error>) -> Void)
}
