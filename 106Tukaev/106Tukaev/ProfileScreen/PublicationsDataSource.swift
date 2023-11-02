//
//  DataSource.swift
//  106Tukaev
//
//  Created by surexnx on 29.10.2023.
//

import Foundation
import UIKit
class PublicationsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    var dataManager: DataManager = DataManager()
    func setDataManager(dataManeger: DataManager) {
        self.dataManager = dataManeger
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManager.syncGetAll().count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let withReuseIdentifier = ProfileCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath)
            return cell
        } else {
            let withReuseIdentifier = PublicationCollectionViewCell.reuseIdentificator
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as? PublicationCollectionViewCell

            if let cell = cell {
                cell.configureCell(with: dataManager.syncGetAll()[indexPath.row])
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
