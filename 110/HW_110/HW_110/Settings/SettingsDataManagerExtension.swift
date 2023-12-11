import UIKit

extension SettingsDataManager: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let itemsInSection = settingsData.filter { $0.2 == section }
        return itemsInSection.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            index = 0
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        if self.index < settingsData.count {
            let item = settingsData[index]
            cell.configure(title: item.0, icon: item.1, color: item.3, section: item.2)
        }
        self.index += 1
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && indexPath.section == 4 {
            exitButtonActionClosure!()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Ваш аккаунт"
        } else if section == 1 {
            return "Как вы используете ваш Instagram"
        } else if section == 2 {
            return "Что видите вы"
        } else if section == 3 {
            return "Кто может видеть ваш контент"
        } else {
            return "Вход"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}
