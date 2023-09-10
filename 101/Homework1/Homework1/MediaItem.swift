//
//  MediaItem.swift
//  Homework1
//
//  Created by Alina on 11.09.2023.
//

import Foundation

protocol MediaItem{
    var title: String { get set }
    var author: String { get set }
    var year: Int { get set }
    var genre: String { get set }
    var language: String { get set }
}


class Movie: MediaItem{
    var title: String
    var author: String
    var year: Int
    var genre: String
    var language: String
    var duration: Int
    
    init(title: String, author: String, year: Int, genre: String, language: String, duration: Int, feedbacks: [String]) {
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
        self.language = language
        self.duration = duration
    }
}


class Music: MediaItem{
    var title: String
    var author: String
    var year: Int
    var genre: String
    var language: String
    var mood: String
    
    init(title: String, author: String, year: Int, genre: String, language: String, mood: String, feedbacks: [String]) {
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
        self.language = language
        self.mood = mood
    }
    
}


class Book:MediaItem{
    var title: String
    var author: String
    var year: Int
    var genre: String
    var language: String
    var mood: String
    
    init(title: String, author: String, year: Int, genre: String, language: String, mood: String, feedbacks: [String]) {
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
        self.language = language
        self.mood = mood
    }
    
}


class LibraryMeneger{
    var movieList:[Movie] = []
    var musicList:[Music] = []
    var bookList:[Book] = []
    
    func addMediaItem(item: MediaItem) {
            if let movieItem = item as? Movie {
                movieList.append(movieItem)

            } else if let musicItem = item as? Music {
                musicList.append(musicItem)

            } else if let bookItem = item as? Book {
                bookList.append(bookItem)
            }
        }
    
    func removeMediaItem(item: MediaItem) {
        if let index = movieList.firstIndex(where: { $0.title == item.title }) {
            movieList.remove(at: index)
        } else if let index = musicList.firstIndex(where: { $0.title == item.title }) {
            musicList.remove(at: index)
        }else if let index = bookList.firstIndex(where: { $0.title == item.title }) {
            bookList.remove(at: index)
        }
    }
    
    func searchMediaItemByTitle(item: MediaItem) -> MediaItem{
        if let index = movieList.firstIndex(where: { $0.title == item.title }) {
            return movieList[index]
        } else if let index = musicList.firstIndex(where: { $0.title == item.title }) {
            return musicList[index]
        }else if let index = bookList.firstIndex(where: { $0.title == item.title }) {
            return bookList[index]
        }
        return "Oops, what you're looking for isn't here" as! MediaItem
    }
    
    func searchMediaItemByAuthor(item: MediaItem) -> MediaItem{
        if let index = movieList.firstIndex(where: { $0.author == item.author }) {
            return movieList[index]
        } else if let index = musicList.firstIndex(where: { $0.author == item.author}) {
            return musicList[index]
        }else if let index = bookList.firstIndex(where: { $0.author == item.author }) {
            return bookList[index]
        }
        return "Oops, what you're looking for isn't here" as! MediaItem
    }
}
