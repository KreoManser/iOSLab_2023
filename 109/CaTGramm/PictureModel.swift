//
//  PictureModel.swift
//  CaTGramm
//
//  Created by Rustem on 29.10.2023.
//

import UIKit

class PictureModel: Hashable, Identifiable, Codable {
    static func == (lhs: PictureModel, rhs: PictureModel) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
            case id
            case avatar
            case nickname
            case picture
            case detailButton
            case likeButton
            case commentButton
            case shareButton
            case savedPicturesButton
            case text
            case date
        }
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(nickname, forKey: .nickname)
            try container.encode(text, forKey: .text)
            try container.encode(date, forKey: .date)
        }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        detailButton = UIButton()
        likeButton = TempButton.createLikeButton()
        commentButton = TempButton.createCommentButton()
        shareButton = TempButton.createShareButton()
        savedPicturesButton = TempButton.createFavButton()
        self.id = try values.decode(UUID.self, forKey: .id)
        let nickname = try values.decode(String.self, forKey: .nickname)
        self.nickname = nickname
        self.avatar = UIImage()
        self.picture = UIImage()
        self.text = try values.decode(String.self, forKey: .text)
        self.date = Date()
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
