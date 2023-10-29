import Foundation

protocol DataManagerProtocol {
    func syncSave(_ model: Post)
    func asyncSave(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void)
    func syncDelete(_ model: Post)
    func asyncDelete(_ model: Post, completion: @escaping (Result<Void, Error>) -> Void)
    func syncGetAllPosts() -> [Post]
    func asyncGetAllPosts(completion: @escaping (Result<[Post], Error>) -> Void)
    func syncSearchPosts(by caption: String) -> [Post]
    func asyncSearchPosts(by caption: String, completion: @escaping (Result<[Post], Error>) -> Void)
}
