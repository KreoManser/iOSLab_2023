//
//  UserDataBase.swift
//  HW_106_Minnushin_Artur
//
//  Created by Артур Миннушин on 06.11.2023.
//

import Foundation

struct User1 {
    let userLogin: String
    let userPassword: String
    let userId: Int
    let userName: String
    let userAvatarImageName: String
    let userCountPosts: Int
    let userCountFolowing: Int
    let userCountFolowers: Int
    let userDescription: String
    var posts: [PostInfo]
    var likePosts: [PostInfo]
}

struct PostInfo {
    let postID: Int
    let userPostId: Int
    var isLiked: Bool
    var counterLikes: Int
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
    var coreDataManger = CoreDataManager.shared
    var users: [User1] = [
        User1(userLogin: "1", userPassword: "1",
             userId: 1,
             userName: "Artur Minnushin", userAvatarImageName: "avatar1",
             userCountPosts: 10, userCountFolowing: 10,
             userCountFolowers: 10,
             userDescription: "Я iOS разработчик и кот :)",
             posts:
                [
                    PostInfo(postID: 1, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 1, mounth: 1, year: 2020), postComment: "пост 1"),
                    PostInfo(postID: 2, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 4, mounth: 1, year: 2020), postComment: "пост 2"),
                    PostInfo(postID: 3, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 7, mounth: 1, year: 2020), postComment: "пост 3"),
                    PostInfo(postID: 4, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 10, mounth: 1, year: 2020), postComment: "пост 4"),
                    PostInfo(postID: 5, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 13, mounth: 1, year: 2020), postComment: "пост 5"),
                    PostInfo(postID: 6, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 16, mounth: 1, year: 2020), postComment: "пост 6"),
                    PostInfo(postID: 7, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 19, mounth: 1, year: 2020), postComment: "пост 7"),
                    PostInfo(postID: 8, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 22, mounth: 1, year: 2020), postComment: "пост 8"),
                    PostInfo(postID: 9, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 25, mounth: 1, year: 2020), postComment: "пост 9"),
                    PostInfo(postID: 10, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 28, mounth: 1, year: 2020), postComment: "пост 10"),
                    PostInfo(postID: 11, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 31, mounth: 1, year: 2020), postComment: "пост 11"),
                    PostInfo(postID: 12, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 3, mounth: 2, year: 2020), postComment: "пост 12"),
                    PostInfo(postID: 13, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 6, mounth: 2, year: 2020), postComment: "пост 13"),
                    PostInfo(postID: 14, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 9, mounth: 2, year: 2020), postComment: "пост 14"),
                    PostInfo(postID: 15, userPostId: 1, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo1",
                             postDate: MyDate(day: 12, mounth: 2, year: 2020), postComment: "пост 15")], likePosts: []),
        User1(userLogin: "2", userPassword: "2",
             userId: 2, userName: "Timofei Brisovix",
             userAvatarImageName: "avatar2", userCountPosts: 10,
             userCountFolowing: 10, userCountFolowers: 10,
             userDescription: "Я кот и что :)", posts:
                [
                    PostInfo(postID: 1, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 2, mounth: 1, year: 2020), postComment: "пост 1"),
                    PostInfo(postID: 2, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 5, mounth: 1, year: 2020), postComment: "пост 2"),
                    PostInfo(postID: 3, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 8, mounth: 1, year: 2020), postComment: "пост 3"),
                    PostInfo(postID: 4, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 11, mounth: 1, year: 2020), postComment: "пост 4"),
                    PostInfo(postID: 5, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 14, mounth: 1, year: 2020), postComment: "пост 5"),
                    PostInfo(postID: 6, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 17, mounth: 1, year: 2020), postComment: "пост 6"),
                    PostInfo(postID: 7, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 20, mounth: 1, year: 2020), postComment: "пост 7"),
                    PostInfo(postID: 8, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 23, mounth: 1, year: 2020), postComment: "пост 8"),
                    PostInfo(postID: 9, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 26, mounth: 1, year: 2020), postComment: "пост 9"),
                    PostInfo(postID: 10, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 29, mounth: 1, year: 2020), postComment: "пост 10"),
                    PostInfo(postID: 11, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 1, mounth: 2, year: 2020), postComment: "пост 11"),
                    PostInfo(postID: 12, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 4, mounth: 2, year: 2020), postComment: "пост 12"),
                    PostInfo(postID: 13, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 7, mounth: 2, year: 2020), postComment: "пост 13"),
                    PostInfo(postID: 14, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 10, mounth: 2, year: 2020), postComment: "пост 14"),
                    PostInfo(postID: 15, userPostId: 2, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo2",
                             postDate: MyDate(day: 13, mounth: 2, year: 2020), postComment: "пост 15")], likePosts: []),
        User1(userLogin: "login3", userPassword: "pasword3",
             userId: 3, userName: "Bond, Cat Bond",
             userAvatarImageName: "avatar3", userCountPosts: 10,
             userCountFolowing: 10, userCountFolowers: 10,
             userDescription: "Меня сложно найти, легко потерять и невозможно убить. Я Bond, Cat Bond",
             posts:
                [
                    PostInfo(postID: 1, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 3, mounth: 1, year: 2020), postComment: "пост 1"),
                    PostInfo(postID: 2, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 6, mounth: 1, year: 2020), postComment: "пост 2"),
                    PostInfo(postID: 3, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 9, mounth: 1, year: 2020), postComment: "пост 3"),
                    PostInfo(postID: 4, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 12, mounth: 1, year: 2020), postComment: "пост 4"),
                    PostInfo(postID: 5, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 15, mounth: 1, year: 2020), postComment: "пост 5"),
                    PostInfo(postID: 6, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 18, mounth: 1, year: 2020), postComment: "пост 6"),
                    PostInfo(postID: 7, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 21, mounth: 1, year: 2020), postComment: "пост 7"),
                    PostInfo(postID: 8, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 24, mounth: 1, year: 2020), postComment: "пост 8"),
                    PostInfo(postID: 9, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 27, mounth: 1, year: 2020), postComment: "пост 9"),
                    PostInfo(postID: 10, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 30, mounth: 1, year: 2020), postComment: "пост 10"),
                    PostInfo(postID: 11, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 2, mounth: 2, year: 2020), postComment: "пост 11"),
                    PostInfo(postID: 12, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 5, mounth: 2, year: 2020), postComment: "пост 12"),
                    PostInfo(postID: 13, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 8, mounth: 2, year: 2020), postComment: "пост 13"),
                    PostInfo(postID: 14, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 11, mounth: 2, year: 2020), postComment: "пост 14"),
                    PostInfo(postID: 15, userPostId: 3, isLiked: false, counterLikes: 0, postPhotoNmae: "Photo3",
                             postDate: MyDate(day: 14, mounth: 2, year: 2020), postComment: "пост 15")], likePosts: [])]
    func getData() -> [User1] {
        return users
    }
    
}
