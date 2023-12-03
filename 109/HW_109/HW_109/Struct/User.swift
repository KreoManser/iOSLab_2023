import UIKit
struct User: Codable {
    let id: String
    let login: String
    let password: String
    let avatarData: Data
    let fullName: String
    var avatar: UIImage? {
        return UIImage(data: avatarData)
    }
    init(id: String, login: String, password: String, avatar: UIImage, fullName: String) {
        self.id = id
        self.login = login
        self.password = password
        self.avatarData = avatar.pngData() ?? Data()
        self.fullName = fullName
    }
    func toData() -> Data? {
        do {
            let encoder = JSONEncoder()
            return try encoder.encode(self)
        } catch {
            print("Error encoding User to Data: \(error.localizedDescription)")
            return nil
        }
    }
    static func fromData(_ data: Data) -> User? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(User.self, from: data)
        } catch {
            print("Error decoding User from Data: \(error.localizedDescription)")
            return nil
        }
    }
}
