//
//  HistoryDataSource.swift
//  107Tukaev
//
//  Created by surexnx on 06.11.2023.
//

import Foundation
import UIKit

class HistoryDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let withReuseIdentifier = HistoryCollectionViewCell.reuseIdentificator
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: withReuseIdentifier, for: indexPath) as? HistoryCollectionViewCell
        if let cell = cell {
            return cell
        }
        return UICollectionViewCell()
    }

}
