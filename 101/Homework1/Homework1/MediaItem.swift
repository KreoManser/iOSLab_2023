//
//  MediaItem.swift
//  HomeWork1
//
//  Created by Alina on 14.09.2023.
//

import Foundation

protocol MediaItem {
    var title: String { get set }
    var author: String { get set }
    var year: String { get set }
    var genre: String { get set }
    var language: String { get set }
}


class MovieItem: MediaItem, CustomStringConvertible{
    var title: String
    var author: String
    var year: String
    var genre: String
    var language: String
    var duration: String
    
    init(title: String, author: String, year: String, genre: String, language: String, duration: String) {
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
        self.language = language
        self.duration = duration
    }
    
    public var description: String {return "This book: Title: \(title), Author: \(author), Year: \(year), Genre: \(genre), Language: \(language), Duration: \(duration)"}
}


class MusicItem: MediaItem, CustomStringConvertible{
    var title: String
    var author: String
    var year: String
    var genre: String
    var language: String
    var mood: String
    
    init(title: String, author: String, year: String, genre: String, language: String, mood: String) {
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
        self.language = language
        self.mood = mood
    }
    public var description: String {return "This book: Title: \(title), Author: \(author), Year: \(year), Genre: \(genre), Language: \(language), Mood: \(mood)"}
    
}


class BookItem: MediaItem, CustomStringConvertible{
    var title: String
    var author: String
    var year: String
    var genre: String
    var language: String
    var mood: String
    
    init(title: String, author: String, year: String, genre: String, language: String, mood: String) {
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
        self.language = language
        self.mood = mood
    }
    
    public var description: String {return "This book: Title: \(title), Author: \(author), Year: \(year), Genre: \(genre), Language: \(language), Mood: \(mood)"}

}

class LibraryManager {
    private var musicItems: [MusicItem] = []
    private var bookItems: [BookItem] = []
    private var movieItems: [MovieItem] = []
    
    // Music methods
    func searchMusicItemByTitle(title: String) -> [MusicItem] {
        return musicItems.filter { $0.title == title }
    }
    
    func searchMusicItemByAuthor(author: String) -> [MusicItem] {
        return musicItems.filter { $0.author == author }
    }
    
    // Book methods
    func searchBookItemByTitle(title: String) -> [BookItem] {
        return bookItems.filter { $0.title == title }
    }
    
    func searchBookItemByAuthor(author: String) -> [BookItem] {
        return bookItems.filter { $0.author == author }
    }
    
    // Movie methods
    func searchMovieItemByTitle(title: String) -> [MovieItem] {
        return movieItems.filter { $0.title == title }
    }
    
    func searchMovieItemByAuthor(author: String) -> [MovieItem] {
        return movieItems.filter { $0.author == author }
    }
    
    // General methods
    func addMediaItem(item: MediaItem) {
        if let musicItem = item as? MusicItem {
            musicItems.append(musicItem)
        } else if let bookItem = item as? BookItem {
            bookItems.append(bookItem)
        } else if let movieItem = item as? MovieItem {
            movieItems.append(movieItem)
        }
    }
    
    func removeMediaItem(item: MediaItem) {
        if let musicItem = item as? MusicItem,
           let index = musicItems.firstIndex(where: { $0.title == musicItem.title && $0.author == musicItem.author }) {
            musicItems.remove(at: index)
        } else if let bookItem = item as? BookItem,
                  let index = bookItems.firstIndex(where: { $0.title == bookItem.title && $0.author == bookItem.author }) {
            bookItems.remove(at: index)
        } else if let movieItem = item as? MovieItem,
                  let index = movieItems.firstIndex(where: { $0.title == movieItem.title && $0.author == movieItem.author }) {
            movieItems.remove(at: index)
        }
    }
}
