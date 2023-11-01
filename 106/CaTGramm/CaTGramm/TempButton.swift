//
//  LikeButton.swift
//  CaTGramm
//
//  Created by Rustem on 01.11.2023.
//

import UIKit

class TempButton {
    public static func createLikeButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }
    public static func createCommentButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }
    public static func createShareButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }
    public static func createFavButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }
}
