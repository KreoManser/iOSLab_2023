//
//  StoryDataManager.swift
//  homework_7
//
//  Created by Кирилл Щёлоков on 05.11.2023.
//

import Foundation
import UIKit

class StoryDataManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var stories: [String: [Story]] = [:]

    static let shared = StoryDataManager()

    private var pushinkaStories: [Story] = [
        Story(id: UUID(), storyImage: UIImage.cat1),
        Story(id: UUID(), storyImage: UIImage.cat2),
        Story(id: UUID(), storyImage: UIImage.cat3),
        Story(id: UUID(), storyImage: UIImage.cat4),
        Story(id: UUID(), storyImage: UIImage.cat5),
        Story(id: UUID(), storyImage: UIImage.cat6)
    ]

    private var adminStories: [Story] = [
        Story(id: UUID(), storyImage: UIImage.adminLogo),
        Story(id: UUID(), storyImage: UIImage.adminLogo),
        Story(id: UUID(), storyImage: UIImage.adminLogo),
        Story(id: UUID(), storyImage: UIImage.adminLogo),
        Story(id: UUID(), storyImage: UIImage.adminLogo),
        Story(id: UUID(), storyImage: UIImage.adminLogo)
    ]

    private var dogLoverStories: [Story] = [
        Story(id: UUID(), storyImage: UIImage.dog1),
        Story(id: UUID(), storyImage: UIImage.dog2),
        Story(id: UUID(), storyImage: UIImage.dog3),
        Story(id: UUID(), storyImage: UIImage.dogLogo),
        Story(id: UUID(), storyImage: UIImage.dog1),
        Story(id: UUID(), storyImage: UIImage.dog2)
    ]

    private override init() {
        super.init()
        stories["Pushinka.52NGG"] = pushinkaStories
        stories["Admin"] = adminStories
        stories["dogLover"] = dogLoverStories
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        stories[LogInDataManager.authUser]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 75.0
        let height = 65.0
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                StoryCollectionViewCell.reuseIdentifier, for: indexPath) as? StoryCollectionViewCell
        else { return UICollectionViewCell()}

        cell.configure(with: getStoriesArray()[indexPath.row])
        cell.contentMode = .scaleAspectFill
        cell.clipsToBounds = true

        return cell
    }

    private func getStoriesArray() -> [Story] {
        if let storyArray = stories[LogInDataManager.authUser] {
            return storyArray
        } else {
            return []
        }
    }
}
