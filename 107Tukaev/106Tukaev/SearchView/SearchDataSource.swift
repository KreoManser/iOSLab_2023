//
//  SearchDataSource.swift
//  107Tukaev
//
//  Created by surexnx on 11.12.2023.
//

import Foundation
import UIKit

class SearchDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var dataManager = CoreDataManager.shared

    private var users: [User] = []
    var searchText: String

    override init() {
        searchText = ""
        users = dataManager.searchUser(searchPrefix: searchText)
    }

    func setSearchText(text: String) {
        searchText = text
        users = dataManager.searchUser(searchPrefix: searchText)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let withIdentificator = SearchCollectionViewCell.reuseIdentificator

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withIdentificator, for: indexPath) as? SearchCollectionViewCell
        if let cell = cell {
            cell.delegate = collectionView.superview as? any CellTapDelegate
            cell.configureCell(user: users[indexPath.row])
        }
        return cell ?? SearchCollectionViewCell()
    }
}
