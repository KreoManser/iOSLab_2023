//
//  StoryDataManager.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 04.11.2023.
//

import Foundation
import UIKit

class StoryDataManager: NSObject, UICollectionViewDataSource,
                            UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    static let shared = StoryDataManager()
    var stories: [StoryAvatar] = [
        StoryAvatar(image: UIImage(named: "profile01")),
        StoryAvatar(image: UIImage(named: "dp2")),
        StoryAvatar(image: UIImage(named: "dp3")),
        StoryAvatar(image: UIImage(named: "dp6")),
        StoryAvatar(image: UIImage(systemName: "person")),
        StoryAvatar(image: UIImage(named: "profile2")),
        StoryAvatar(image: UIImage(named: "profile3")),
        StoryAvatar(image: UIImage(systemName: "person")),
        StoryAvatar(image: UIImage(named: "dp3")),
        StoryAvatar(image: UIImage(named: "dp1")),
        StoryAvatar(image: UIImage(named: "nature3"))

    ]

    override init() {}

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(stories.count)
        return stories.count
    }
    func collectionView(_ collectionView: UICollectionView,

                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView:cellForItemAt")
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StoryCollectionViewCell.storyID,
            for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell() }
        let avatars = stories
        let image = avatars[indexPath.row]
        cell.configure(with: image)
        cell.contentMode = .scaleAspectFill
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView,

                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int)
    -> CGFloat {
        return 1
    }
}
