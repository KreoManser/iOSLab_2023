//
//  SettingsDataManager.swift
//  homework_9
//
//  Created by Кирилл Щёлоков on 24.11.2023.
//

import Foundation
import UIKit

class SettingsDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {

    private let headerTitles = ["Настройки отображения", "Какие-то настройки"]

    var cellTapped: ((_ goViewController: UIViewController) -> Void)?

    private let settingData: [[Setting]] = [
        [
            Setting(
                viewController: DarkThemeViewController(navigationTitle: "Тёмная тема"),
                settingDescription: "Тёмная тема",
                settingImage: UIImage.moonIcon),
            Setting(
                viewController: nil,
                settingDescription: "Ещё какая-то настройка отображения",
                settingImage: UIImage.settingIcon)
        ],
        [
            Setting(
                viewController: nil,
                settingDescription: "Какая-то настройка в другой секции 1",
                settingImage: UIImage.settingIcon),
            Setting(
                viewController: nil,
                settingDescription: "Какая-то настройка в другой секции 2",
                settingImage: UIImage.settingIcon)
        ]
    ]

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let goViewController = settingData[indexPath.section][indexPath.row].viewController else { return }
        cellTapped?(goViewController)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return settingData.count
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingData[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.reuseIdentifier,
            for: indexPath) as? SettingTableViewCell
        else { return UITableViewCell()}

        cell.configure(with: settingData[indexPath.section][indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
