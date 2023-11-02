//
//  DataBase.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 31.10.2023.
//

import Foundation

struct PostInfo {
    let postID: Int
    let postPhotoNmae: String
    let postDate: String
    let postComment: String
}

class DataBase {
    func getData() -> [PostInfo] {
        [
            PostInfo(postID: 1, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 1"),
            PostInfo(postID: 2, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 2"),
            PostInfo(postID: 3, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 3"),
            PostInfo(postID: 4, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 4"),
            PostInfo(postID: 5, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 5"),
            PostInfo(postID: 6, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 6"),
            PostInfo(postID: 7, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 7"),
            PostInfo(postID: 8, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 8"),
            PostInfo(postID: 9, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 9"),
            PostInfo(postID: 10, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 10"),
            PostInfo(postID: 11, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 11"),
            PostInfo(postID: 12, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 12"),
            PostInfo(postID: 13, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 13"),
            PostInfo(postID: 14, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 14"),
            PostInfo(postID: 15, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 15")
        ]
    }
}
