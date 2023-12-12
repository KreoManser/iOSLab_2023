//
//  PictureModel.swift
//  CaTGramm
//
//  Created by Rustem on 29.10.2023.
//

import UIKit

class PictureModel: Hashable, Identifiable {
    static func == (lhs: PictureModel, rhs: PictureModel) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    var id: UUID
    //    Аватар, ваш ник, кнопка 3 точки
    var avatar: UIImage
    var nickname: String
    var detailButton: UIButton
    //    * Фото
    var picture: UIImage
    //    * Лайк, коммент, шаринг, избранное
    var likeButton: UIButton
    var commentButton: UIButton
    var shareButton: UIButton
    var savedPicturesButton: UIButton
    //    * Некая подпись добавленная вами.
    var text: String
    //    * Дата поста.
    var date: Date

    init(avatar: UIImage, nickname: String, picture: UIImage, text: String) {
        detailButton = UIButton()
        likeButton = TempButton.createLikeButton()
        commentButton = TempButton.createCommentButton()
        shareButton = TempButton.createShareButton()
        savedPicturesButton = TempButton.createFavButton()
        self.id = UUID()
        self.avatar = avatar
        self.nickname = nickname
        self.picture = picture
        self.text = text
        self.date = Date()
    }
}
