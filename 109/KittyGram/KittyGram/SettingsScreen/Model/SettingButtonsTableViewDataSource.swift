//
//  SettingButtonsTableViewDataSource.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 01.12.2023.
//

import Foundation
import UIKit

class SettingButtonsTableViewDataSource: NSObject, UITableViewDataSource {
    private let buttons = ButtonsHandler.shared.settingsButton

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingButtonTableViewCell.reuseIdentifier,
            for: indexPath) as? SettingButtonTableViewCell

        guard let cell = cell else { return UITableViewCell() }
        cell.configureCell(with: buttons[indexPath.row])
        return cell
    }

}
