import UIKit
protocol DataChangeProtocol {
    associatedtype Model
    func syncSave(model: Model) throws
    func asyncSave(model: Model, completion: @escaping (Result<Void, Error>) -> Void)
    func syncGet() throws -> [Model]
    func asyncGet(completion: @escaping (Result<[Model], Error>) -> Void)
    func syncDelete(model: Model) throws
    func asyncDelete(model: Model, completion: @escaping (Result<Void, Error>) -> Void)
    func syncFind(model comment: String) throws -> [Model]
    func asyncFind(model comment: String, completion: @escaping (Result<[Model], Error>) -> Void)
}
