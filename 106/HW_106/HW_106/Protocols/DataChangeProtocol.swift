import Foundation
protocol DataChangeProtocol {
    associatedtype Model
    func syncSave(model: Model) throws
    func asyncSave(model: Model, completion: @escaping (Result<Void, Error>) -> Void)
    func syncGetModels() throws -> [Model]
    func asyncGetModels(completion: @escaping (Result<[Model], Error>) -> Void)
    func syncDelete(model: Model) throws
    func asyncDelete(model: Model, completion: @escaping (Result<Void, Error>) -> Void)
    func syncFindModel(model comment: String) throws -> [Model]
    func asyncFindModel(model comment: String, completion: @escaping (Result<[Model], Error>) -> Void)
}
