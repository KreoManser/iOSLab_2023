protocol DataChangeProtocol {
    func syncSave(model photo: Photo)
    func asyncSave(model photo: Photo) async
    func syncGet() throws -> [Photo]
    func asyncGet() async -> [Photo]
    func syncDelete(model photo: Photo) throws
    func asyncDelete(model photo: Photo) async
    func syncFind(model comment: String) throws -> [Photo]
    func asyncFind(model comment: String) async -> [Photo]
}
