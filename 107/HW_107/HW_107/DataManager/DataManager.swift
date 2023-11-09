import UIKit
protocol UpdateDataDelegate: AnyObject {
    func dataDidChange()
}
class DataManager: NSObject {
//    private let dataSource = DataSource()
//    lazy var photos: [Photo] = {
//        var tempPhotos: [Photo] = []
//        for index in 0..<8 {
//            tempPhotos.append(dataSource.photoDataSource[index])
//        }
//        return tempPhotos
//    }()
//    weak var delegate: UpdateDataDelegate?
//    func updateUI() {
//        delegate?.dataDidChange()
//    }
//    func syncSave(model photo: Photo) {
//        photos.append(photo)
//        updateUI()
//    }
//    func asyncSave(model photo: Photo) async {
//        return await withCheckedContinuation { continuation in
//            DispatchQueue.global().asyncAfter(deadline: .now()) {
//                self.photos.append(photo)
//                self.updateUI()
//                continuation.resume()
//            }
//        }
//    }
//    func syncGet() throws -> [Photo] {
//        return photos
//    }
//    func asyncGet() async -> [Photo] {
//        return await withCheckedContinuation { continuation in
//            DispatchQueue.global().asyncAfter(deadline: .now()) {
//                continuation.resume(returning: self.photos)
//            }
//        }
//    }
//    func syncDelete(model photo: Photo) throws {
//        if let index = photos.firstIndex(where: { $0.id == photo.id }) {
//            photos.remove(at: index)
//        }
//        updateUI()
//    }
//    func asyncDelete(model photo: Photo) async {
//        await withCheckedContinuation { continuation in
//            DispatchQueue.global().asyncAfter(deadline: .now()) {
//                if let index = self.photos.firstIndex(where: { $0.id == photo.id }) {
//                    self.photos.remove(at: index)
//                    print(self.photos.count)
//                }
//                continuation.resume()
//            }
//        }
//    }
//    func syncFind(model comment: String) throws -> [Photo] {
//        let findPublications = photos.filter { $0.comment.contains(comment) }
//        return findPublications
//    }
//    func asyncFind(model comment: String) async throws -> [Photo] {
//        return await withCheckedContinuation { continuation in
//            DispatchQueue.global().asyncAfter(deadline: .now()) {
//                continuation.resume(returning: self.photos.filter { $0.comment.contains(comment) })
//            }
//        }
//    }
}
