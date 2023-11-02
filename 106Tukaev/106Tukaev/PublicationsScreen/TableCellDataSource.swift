//
//  TableCellDataSource.swift
//  106Tukaev
//
//  Created by surexnx on 01.11.2023.
//

import Foundation
import UIKit

class TableCellDataSource: NSObject, UITableViewDataSource {

    var dataManager: DataManager = DataManager()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.syncGetAll().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let withIdentificator = PublicationsTableViewCell.reuseIdentificator
        let cell = tableView.dequeueReusableCell(withIdentifier: withIdentificator, for: indexPath) as? PublicationsTableViewCell
        if let cell = cell {
            let getPublication = dataManager.syncGetAll()[indexPath.row]
            cell.selectionStyle = .none
            cell.configureCell(publication: getPublication)
            return cell
        }
        return UITableViewCell()
    }
}
