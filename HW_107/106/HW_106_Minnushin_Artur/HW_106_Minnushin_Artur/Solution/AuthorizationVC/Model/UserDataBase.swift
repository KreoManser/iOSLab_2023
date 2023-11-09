//
//  UserDataBase.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 06.11.2023.
//

import Foundation

struct User {
    let userLogin: String
    let userPassword: String
    let userId: Int
    let userName: String
    let userAvatarImageName: String
    let userCountPosts: Int
    let userCountFolowing: Int
    let userCountFolowers: Int
    let userDescription: String
    let posts: [PostInfo]
}

struct PostInfo {
    let postID: Int
    let postPhotoNmae: String
    let postDate: String
    let postComment: String
}

class UserDataBase {
    var users: [User] = [
        User(userLogin: "1", userPassword: "1",
             userId: 1,
             userName: "Artur Minnushin", userAvatarImageName: "avatar",
             userCountPosts: 10, userCountFolowing: 10,
             userCountFolowers: 10, userDescription: "Я iOS разработчик и кот :)",
             posts:
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
                    PostInfo(postID: 15, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 15")]),
        User(userLogin: "2", userPassword: "2",
             userId: 2, userName: "Timofei Brisovix",
             userAvatarImageName: "avatar1", userCountPosts: 10,
             userCountFolowing: 10, userCountFolowers: 10,
             userDescription: "Я кот и что :)", posts:
                [
                    PostInfo(postID: 1, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 1"),
                    PostInfo(postID: 2, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 2"),
                    PostInfo(postID: 3, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 3"),
                    PostInfo(postID: 4, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 4"),
                    PostInfo(postID: 5, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 5"),
                    PostInfo(postID: 6, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 6"),
                    PostInfo(postID: 7, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 7"),
                    PostInfo(postID: 8, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 8"),
                    PostInfo(postID: 9, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 9"),
                    PostInfo(postID: 10, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 10"),
                    PostInfo(postID: 11, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 11"),
                    PostInfo(postID: 12, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 12"),
                    PostInfo(postID: 13, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 13"),
                    PostInfo(postID: 14, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 14"),
                    PostInfo(postID: 15, postPhotoNmae: "Photo2", postDate: "01.01.2020", postComment: "пост 15")]),
        User(userLogin: "login3", userPassword: "pasword3",
             userId: 3, userName: "Bond, Cat Bond",
             userAvatarImageName: "avatar2", userCountPosts: 10,
             userCountFolowing: 10, userCountFolowers: 10,
             userDescription: "Меня сложно найти, лего потреять и не возмжно убить",
             posts:
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
                    PostInfo(postID: 15, postPhotoNmae: "Photo1", postDate: "01.01.2020", postComment: "пост 15")])]
    func getData() -> [User] {
        return users
    }
}
