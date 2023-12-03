import UIKit
class SettingsDataManager: NSObject {
    static var shared = SettingsDataManager()
    let dataManager = ProfileDataManager.shared
    var settingsData = [(String, UIImage, Int, UIColor)]()
    var exitButtonActionClosure: (() -> Void)?
    var currentSection = 0
    var index = 0
    private override init() {
        super.init()
        setData()
    }
    @objc private func exitButtonTapped() {
        exitButtonActionClosure?()
    }
    func setExitButtonActionClosure(_ closure: @escaping () -> Void) {
        exitButtonActionClosure = closure
    }
    func actionsAfterUserExitFromAccount() {
        dataManager.removeUserFromUserDefaults()
        dataManager.photosProfile = []
        dataManager.photosSubscribers = []
        dataManager.setLikedPhotosInUserDefaults()
        FriendsDataManager.shared.clearData()
    }
    func setData() {
        settingsData.append(("Центр аккаунтов", .accountCenter, 0, .white))
        settingsData.append(("Уведомления", .bell, 1, .white))
        settingsData.append(("Потраченное время", .clock, 1, .white))
        settingsData.append(("Избранное", .star, 2, .white))
        settingsData.append(("Скрытые аккаунты", .hideAccount, 2, .white))
        settingsData.append(("Рекомендуемый контент", .recomendation, 2, .white))
        settingsData.append(("Число отметок 'Нравится'", .countFavourite, 2, .white))
        settingsData.append(("Конфиденциальность", .confident, 3, .white))
        settingsData.append(("Близкие друзья", .bestFriend, 3, .white))
        settingsData.append(("Добавить аккаунт", UIImage(), 4, .blue))
        settingsData.append(("Выйти", UIImage(), 4, .red))
    }
}
