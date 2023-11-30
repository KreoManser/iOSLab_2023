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
    let userPostId: Int
    let postPhotoNmae: String
    let postDate: MyDate
    let postComment: String
}
struct MyDate {
    var day: Int
    var mounth: Int
    var year: Int
    init(day: Int, mounth: Int, year: Int) {
        if day <= 0 || day >= 32 {
            self.day = 1
        } else {
            self.day = day
        }
        if mounth <= 0 || mounth >= 13 {
            self.mounth = 1
            if self.mounth == 2 {
                if self.day > 29 {
                    self.day = 1
                }
            }
        } else {
            self.mounth = mounth
        }
        if year <= 0 {
            self.year = 1
        } else {
            self.year = year
        }
    }
    func getDataInString() -> String {
        var dayStr = ""
        var mounthStr = ""
        if day < 10 {
            dayStr = "0\(day)"
        } else {
            dayStr = "\(day)"
        }
        if mounth < 10 {
            mounthStr = "0\(mounth)"
        } else {
            mounthStr = "\(mounth)"
        }
        return "\(dayStr).\(mounthStr).\(year)"
    }
}

class UserDataBase {
    static var sigelton = UserDataBase()
    var users: [User] = [
        User(userLogin: "1", userPassword: "1",
             userId: 1,
             userName: "Artur Minnushin", userAvatarImageName: "avatar1",
             userCountPosts: 10, userCountFolowing: 10,
             userCountFolowers: 10,
             userDescription: "Я iOS разработчик и кот :)",
             posts:
                [
                    PostInfo(postID: 1, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 1"),
                    PostInfo(postID: 2, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 9, mounth: 10, year: 2020), postComment: "пост 2"),
                    PostInfo(postID: 3, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 3"),
                    PostInfo(postID: 4, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 4"),
                    PostInfo(postID: 5, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 5"),
                    PostInfo(postID: 6, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 6"),
                    PostInfo(postID: 7, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 7"),
                    PostInfo(postID: 8, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 8"),
                    PostInfo(postID: 9, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 9"),
                    PostInfo(postID: 10, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 10"),
                    PostInfo(postID: 11, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 11"),
                    PostInfo(postID: 12, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 12"),
                    PostInfo(postID: 13, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 13"),
                    PostInfo(postID: 14, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 14"),
                    PostInfo(postID: 15, userPostId: 1, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 15")]),
        User(userLogin: "2", userPassword: "2",
             userId: 2, userName: "Timofei Brisovix",
             userAvatarImageName: "avatar2", userCountPosts: 10,
             userCountFolowing: 10, userCountFolowers: 10,
             userDescription: "Я кот и что :)", posts:
                [
                    PostInfo(postID: 1, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 1"),
                    PostInfo(postID: 2, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 2"),
                    PostInfo(postID: 3, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 3"),
                    PostInfo(postID: 4, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 4"),
                    PostInfo(postID: 5, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 5"),
                    PostInfo(postID: 6, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 6"),
                    PostInfo(postID: 7, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 7"),
                    PostInfo(postID: 8, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 8"),
                    PostInfo(postID: 9, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 9"),
                    PostInfo(postID: 10, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 10"),
                    PostInfo(postID: 11, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 11"),
                    PostInfo(postID: 12, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 12"),
                    PostInfo(postID: 13, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 13"),
                    PostInfo(postID: 14, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 14"),
                    PostInfo(postID: 15, userPostId: 2, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 15")]),
        User(userLogin: "login3", userPassword: "pasword3",
             userId: 3, userName: "Bond, Cat Bond",
             userAvatarImageName: "avatar3", userCountPosts: 10,
             userCountFolowing: 10, userCountFolowers: 10,
             userDescription: "Меня сложно найти, лего потреять и не возмжно убить",
             posts:
                [
                    PostInfo(postID: 1, userPostId: 3, postPhotoNmae: "Photo13",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 1"),
                    PostInfo(postID: 2, userPostId: 4, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 2"),
                    PostInfo(postID: 3, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 3"),
                    PostInfo(postID: 4, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 4"),
                    PostInfo(postID: 5, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 5"),
                    PostInfo(postID: 6, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 6"),
                    PostInfo(postID: 7, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 7"),
                    PostInfo(postID: 8, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 8"),
                    PostInfo(postID: 9, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 9"),
                    PostInfo(postID: 10, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 10"),
                    PostInfo(postID: 11, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 11"),
                    PostInfo(postID: 12, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 12"),
                    PostInfo(postID: 13, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 13"),
                    PostInfo(postID: 14, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 14"),
                    PostInfo(postID: 15, userPostId: 3, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 15")])]
    func getData() -> [User] {
        return users
    }
}
