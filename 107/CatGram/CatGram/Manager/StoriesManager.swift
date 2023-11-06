//
//  StoriesManager.swift
//  CatGram
//
//  Created by Mac on 2023-11-06.
//

import UIKit

class StoriesManager {
    static let storiesManager = StoriesManager()
    private lazy var support = SupportFunctions()
    var stories: [Story] = []

    init() {
        stories = support.createStories()
    }
}
