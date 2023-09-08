//
//  main.swift
//  HomeWork_1
//
//  Created by Камил Хайрутдинов on 07.09.2023.
//

import Foundation

//Rating protocol
protocol ratingProtocol{
    var averageRating: Decimal{get }
    var ratingList:[Int]{get }
    func addScore(score: Int)
}
//Media item class
class mediaItem: ratingProtocol{
    
    let name: String
    let author: String
    
    private var privateRatingList:[Int] = []
    var ratingList:[Int]{
        get{
            return privateRatingList
        }
    }
    
    var averageRating: Decimal{
        get{
            if ratingList.isEmpty{
                return 0
            }
            var ratingSum: Decimal = 0
            for number in ratingList{
                ratingSum += Decimal(number)
            }
            return ratingSum / Decimal(ratingList.count)
        }
    }
    
    init(name:String, author:String) {
        self.name = name
        self.author = author
    }
    
    func addScore(score: Int){
        switch score{
        case ..<0:
            print("Score error, score must be >= 0")
        case 11...:
            print("Score error, must be <= 10")
        default:
            privateRatingList.append(score)
        }
    }
}

//Movie class
class movie: mediaItem{
    let duration:Int
    
    init(name: String, author: String, duration:Int) {
        self.duration = duration
        super.init(name: name, author: author)
    }
}

enum musicGenres{
    case hipHop
    case hyperPop
    case rock
    case classic
    case rap
}

//Music class
class music: mediaItem{
    let genre: musicGenres
    let duration: Int
    init(name: String, author: String, duration: Int, genre: musicGenres) {
        self.genre = genre
        self.duration = duration
        super.init(name: name, author: author)
    }
}

enum bookGenres{
    case detective
    case novel
    case adventure
    case fantasy
    
}

//Book class
class book: mediaItem{
    let genre: bookGenres
    let pageCount: Int
    
    init(name: String, author: String, bookGenre:bookGenres, pageCount: Int) {
        self.genre = bookGenre
        self.pageCount = pageCount
        super.init(name: name, author: author)
    }
}

enum mediaTypes{
    case music
    case book
    case movie
}
//Mutimedia manager class
class multimediaManager{
    var movieList:[movie] = []
    var musicList:[music] = []
    var bookList:[book] = []
    
    func addMediaItemToList(item: mediaItem) {
        if let movieItem = item as? movie {
            movieList.append(movieItem)
            
        } else if let musicItem = item as? music {
            musicList.append(musicItem)
            
        } else if let bookItem = item as? book {
            bookList.append(bookItem)
        } else {
            print("Error: unsupported media type")
        }
    }
    
    func getPopular(mediaType: mediaTypes){
        var i = 0
        switch mediaType{
        case .movie:
            movieList.sort{ $0.averageRating > $1.averageRating }
            print("\t Popular movies:\n")
            for movie in movieList{
                i+=1
                print("\(i). Name: \(movie.name) | Author: \(movie.author) | duration: \(movie.duration) minutes | Rating: \(movie.averageRating)|*\n")
            }
            i = 0
        case .book:
            bookList.sort{$0.averageRating > $1.averageRating}
            print("\t Popular books:\n")
            for book in bookList{
                i+=1
                print("\(i). Name: \(book.name) | Author: \(book.author) | Genre: \(book.genre) | Page count: \(book.pageCount) | Rating: \(book.averageRating)*|\n")
            }
            i = 0
        case .music:
            musicList.sort{$0.averageRating > $1.averageRating}
            print("\t Popular Music:\n")
            for music in musicList{
                i+=1
                print("\(i). Name: \(music.name) | Author: \(music.author) | Genre: \(music.genre) | Duration: \(music.duration) second | Rating: \(music.averageRating)*|\n")
            }
            i = 0
        }
        
        
        
        
    }
}


let manager = multimediaManager()

func addRandomScore(item: mediaItem){
    for _ in 1...10{
        item.addScore(score: Int.random(in: 0...10))
    }
}

//Movies
let theShawshankRedemption = movie(name: "The Shawshank Redemption", author: "Frank Darabont", duration: 144)
let theGodfather = movie(name: "The Godfather", author: "Francis Ford Coppola", duration: 175)
let theDarkKnight = movie(name: "The Dark Knight", author: "Christopher Nolan", duration: 152 )
let schindlersList = movie(name: "Schindler's List", author: "Steven Spielberg", duration: 195 )

addRandomScore(item: theShawshankRedemption)
addRandomScore(item: theGodfather)
addRandomScore(item: theDarkKnight)
addRandomScore(item: schindlersList)

manager.addMediaItemToList(item: theShawshankRedemption)
manager.addMediaItemToList(item: theGodfather)
manager.addMediaItemToList(item: theDarkKnight)
manager.addMediaItemToList(item: schindlersList)

manager.getPopular(mediaType: .movie)

//Book
let iFeelBadAboutMyNeck = book(name: "I Feel Bad About My Neck", author: "Nora Ephron", bookGenre: .adventure , pageCount: 54)
let brokenGlass = book(name: "Broken Glass", author: "Alain Mabanckou ", bookGenre: .novel , pageCount: 101)
let aLittleLife = book(name: "A Little Life", author: "Hanya Yanagihara", bookGenre: .fantasy , pageCount: 59)

manager.addMediaItemToList(item: iFeelBadAboutMyNeck)
manager.addMediaItemToList(item: brokenGlass)
manager.addMediaItemToList(item: aLittleLife)

addRandomScore(item: iFeelBadAboutMyNeck)
addRandomScore(item: brokenGlass)
addRandomScore(item: aLittleLife)

manager.getPopular(mediaType: .book)
//Music

let paintTheTownRed = music(name: "Paint The Town Red", author: "Doja Cat", duration: 134, genre: .hipHop)
let itGoesLikeNananaEdit = music(name: "(It Goes Like) Nanana (Edit)", author: "Peggy Gou", duration: 133, genre: .hipHop)
let strangers = music(name: "Strangers", author: "Kenya Grace", duration: 150, genre: .rap)
let tattoo = music(name: "Tattoo", author: "Loreen", duration: 151, genre: .classic)
let vampire = music(name: "vampire", author: "Olivia Rodrigo", duration: 113, genre: .classic)

manager.addMediaItemToList(item: paintTheTownRed)
manager.addMediaItemToList(item: itGoesLikeNananaEdit)
manager.addMediaItemToList(item: strangers)
manager.addMediaItemToList(item: tattoo)
manager.addMediaItemToList(item: vampire)

addRandomScore(item: paintTheTownRed)
addRandomScore(item: itGoesLikeNananaEdit)
addRandomScore(item: strangers)
addRandomScore(item: tattoo)
addRandomScore(item: vampire)

manager.getPopular(mediaType: .music)

