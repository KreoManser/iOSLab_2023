import UIKit
import Foundation
extension ProfileDataManager: DataChangeProtocol {
    func syncSave(model photo: Photo) {
        saveQueue.addOperation { [weak self] in
            self?.photos.append(photo)
            self?.updateUI()
        }
    }
    func asyncSave(model photo: Photo, completion: @escaping (Result<Void, Error>) -> Void) {
        saveQueue.addOperation { [weak self] in
            self?.photos.append(photo)
            DispatchQueue.main.async {
                self?.updateUI()
                completion(.success(()))
            }
        }
    }
    func syncGetModels() throws -> [Photo] {
        return photos
    }
    func asyncGetModels(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let operation = BlockOperation {
            completion(.success(self.photos))
        }
        getModelsQueue.addOperation(operation)
    }
    func syncDelete(model photo: Photo) throws {
        if let index = photos.firstIndex(where: { $0.id == photo.id }) {
            photos.remove(at: index)
        }
        self.updateUI()
    }
    func asyncDelete(model photo: Photo, completion: @escaping (Result<Void, Error>) -> Void) {
        let operation = BlockOperation {
            if let index = self.photos.firstIndex(where: { $0.id == photo.id }) {
                self.photos.remove(at: index)
            }
        }
        operation.completionBlock = {
            DispatchQueue.global().async {
                completion(.success(()))
            }
        }
        deleteQueue.addOperation(operation)
        self.updateUI()
    }
    func syncFindModel(model comment: String) throws -> [Photo] {
        let findPublications = photos.filter { $0.comment.contains(comment) }
        return findPublications
    }
    func asyncFindModel(model comment: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        let operation = BlockOperation { [self] in
            let findPublications = photos.filter { $0.comment.contains(comment) }
            OperationQueue.main.addOperation {
                completion(.success(findPublications))
            }
        }
        findModelQueue.addOperation(operation)
    }
}
