//
//  main.swift
//  HomeWork_1
//
//  Created by Камил Хайрутдинов on 07.09.2023.
//

import Foundation

//Rating protocol
protocol rating {
    var averageRating: Decimal { get }
    var ratingList: [Int] { get }
    func addScore(score: Int)
}

//Media item class
class mediaItem: rating {
    
    let name: String
    let author: String
    
    private var privateRatingList: [Int] = []
    var ratingList: [Int] {
        get {
            return privateRatingList
        }
    }
    
    var averageRating: Decimal {
        get {
            if ratingList.isEmpty{
                return 0
            }
            var ratingSum: Decimal = 0
            for number in ratingList {
                ratingSum += Decimal(number)
            }
            return ratingSum / Decimal(ratingList.count)
        }
    }
    
    init(name: String, author: String) {
        self.name = name
        self.author = author
        addRandomScore(item: self)
    }
    
    func addScore(score: Int) {
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
class movie: mediaItem {
    let duration:Int
    
    init(name: String, author: String, duration:Int) {
        self.duration = duration
        super.init(name: name, author: author)
    }
}

enum musicGenres: String {
    case hipHop = "1"
    case hyperpop = "2"
    case rock = "3"
    case classic = "4"
    case rap = "5"
    case notStated = "-1"
}

//Music class
class music: mediaItem {
    let genre: musicGenres
    let duration: Int
    init(name: String, author: String, duration: Int, genre: musicGenres) {
        self.genre = genre
        self.duration = duration
        super.init(name: name, author: author)
    }
}

enum bookGenres: String {
    case detective = "1"
    case novel = "2"
    case adventure = "3"
    case fantasy = "4"
    case notStated = "-1"
    
}

//Book class
class book: mediaItem {
    let genre: bookGenres
    let pageCount: Int
    
    init(name: String, author: String, bookGenre:bookGenres, pageCount: Int) {
        self.genre = bookGenre
        self.pageCount = pageCount
        super.init(name: name, author: author)
    }
}

enum mediaTypes: String {
    case music = "1"
    case book = "2"
    case movie = "3"
}

enum searchTypes {
    case author
    case name
}

//Mutimedia manager class
class multimediaManager {
    var movieList: [movie] = []
    var musicList: [music] = []
    var bookList: [book] = []
    
    func movieInfoToString(currentMovie: movie) -> String {
        return "Name: \(currentMovie.name) | Author: \(currentMovie.author) \n\tduration: \(currentMovie.duration) minutes | Rating: \(currentMovie.averageRating)*\n"
    }
    
    func bookInfoToString(currentBook: book) -> String {
        return "Name: \(currentBook.name) | Author: \(currentBook.author) \n\tGenre: \(currentBook.genre) | Page count: \(currentBook.pageCount) | Rating: \(currentBook.averageRating)*\n"
    }
    
    func musicInfoToString(currentMusic: music) -> String {
        return "Name: \(currentMusic.name) | Author: \(currentMusic.author) \n\tGenre: \(currentMusic.genre) | Duration: \(currentMusic.duration) second | Rating: \(currentMusic.averageRating)*\n"
    }
    
    func mediaSearch(searchText: String, mediaType: mediaTypes, searchType: searchTypes) {
        if searchType == .author {
            switch mediaType {
            case .movie:
                let result = movieList.filter{ movie in movie.author == searchText }
                if result.isEmpty {
                    print("Not found")
                }
                else {
                    for movie in result {
                        print(movieInfoToString(currentMovie: movie))
                    }
                }
                
            case .music:
                let result = musicList.filter{ music in music.author == searchText }
                if result.isEmpty {
                    print("Not found")
                }
                else {
                    for music in result {
                        print(musicInfoToString(currentMusic: music))
                    }
                }
                
            case .book:
                let result = bookList.filter{ book in book.author == searchText }
                if result.isEmpty {
                    print("Not found")
                }
                else {
                    for book in result {
                        print(bookInfoToString(currentBook: book))
                    }
                }
            }
        }
        else {
            switch mediaType {
            case .movie:
                let result = movieList.filter{ movie in movie.name == searchText }
                if result.isEmpty {
                    print("Not found")
                }
                else {
                    for movie in result {
                        print(movieInfoToString(currentMovie: movie))
                    }
                }
                
            case .music:
                let result = musicList.filter{ music in music.name == searchText }
                if result.isEmpty {
                    print("Not found")
                }
                else {
                    for music in result {
                        print(musicInfoToString(currentMusic: music))
                    }
                }
                
            case .book:
                let result = bookList.filter{ book in book.name == searchText }
                if result.isEmpty {
                    print("Not found")
                }
                else {
                    for book in result {
                        print(bookInfoToString(currentBook: book))
                    }
                }
            }
        }
    }
    
    func searchNilChecker(input:String?) {
        if(input) == nil {
            print("Ошибка поиска")
            multimediaManagerMenu()
        }
    }
    
    func addMediaItemToList() {
        var name: String
        var author: String
        var duration: Int
        var durationTemp: String
        var musicGenre: String
        var bookGenre: String
        
        print("\tЧто будем добавлять?")
        print("Музыка: введите 1")
        print("Книги: введите 2")
        print("Видео: введите 3")
        
        let temp = readLine() ?? ""
        switch temp {
        case "1":
            print("\tВведите название")
            name = readLine() ?? ""
            print("\tВведите имя автора")
            author = readLine() ?? ""
            print("\tВведите продолжительность")
            durationTemp = readLine() ?? ""
            duration = Int(durationTemp) ?? 0
            
            print("\tвыберете жанр:")
            print("1: Hip-hop")
            print("2: Hyperpop")
            print("3: Rock")
            print("4: Classic")
            print("5: Rap")
            
            musicGenre = readLine() ?? ""
            musicList.append(music(name: name, author: author, duration: duration, genre: musicGenres(rawValue: musicGenre) ?? .notStated))
            print("\tДобавлено!")
            exit()
            
        case "2":
            print("\tВведите название")
            name = readLine() ?? ""
            print("\tВведите имя автора")
            author = readLine() ?? ""
            print("\tВведите кол-во страниц")
            durationTemp = readLine() ?? ""
            duration = Int(durationTemp) ?? 0
            
            print("\tвыберете жанр:")
            print("1: Detective")
            print("2: Novel")
            print("3: Adventure")
            print("4: Fantacy")
            
            bookGenre = readLine() ?? ""
            bookList.append(book(name: name, author: author, bookGenre: bookGenres(rawValue: bookGenre) ?? .notStated, pageCount: duration))
            
            print("\tДобавлено!")
            exit()
            
        case "3":
            print("\tВведите название")
            name = readLine() ?? ""
            print("\tВведите имя автора")
            author = readLine() ?? ""
            print("\tВведите кол-во страниц")
            durationTemp = readLine() ?? ""
            duration = Int(durationTemp) ?? 0
            
            movieList.append(movie(name: name, author: author, duration: duration))
            print("\tДобавлено!")
            exit()
            
        default:
            print("\tОшибка, попробуйте еще раз")
            addMediaItemToList()
        }
    }
    
    func getPopular(mediaType: mediaTypes) {
        switch mediaType {
        case .movie:
            let sortedMovieList = movieList.sorted{ $0.averageRating > $1.averageRating }
            print("\t Popular movies:\n")
            for i in 0..<sortedMovieList.count {
                print("\(i+1). \(movieInfoToString(currentMovie: sortedMovieList[i]))")
            }
            
        case .book:
           let sortedBookList =  bookList.sorted{ $0.averageRating > $1.averageRating }
            print("\t Popular books:\n")
            for i in 0..<sortedBookList.count {
                print("\(i+1). \(bookInfoToString(currentBook: sortedBookList[i]))")
            }
            
        case .music:
            let sortedMusicList = musicList.sorted{ $0.averageRating > $1.averageRating }
            print("\t Popular Music:\n")
            for i in 0..<sortedMusicList.count{
                print("\(i+1). \(musicInfoToString(currentMusic: sortedMusicList[i]))")
            }
        }
    }
    
    func exit() {
        print("для выхода введите 0")
        let input = readLine()
        if input == "0" {
            multimediaManagerMenu()
        }
        else {
            print("Ошибка, попробуйте еще раз\n")
            exit()
        }
    }
    func checkSelection(input: String) -> Bool {
        if "123".contains(input) && input != "123" && input != "12" && input != "23" {
            return true
        }
        else {
            return false
        }
    }
    func removeMedia() {
        print("Музыка: введите 1")
        print("Книги: введите 2")
        print("Видео: введите 3")
        let input = readLine()
        var nameToRemove: String
        if checkSelection(input: input ?? "-1") {
            switch input {
            case "1":
                print("Введите название:")
                nameToRemove = readLine() ?? ""
                musicList.removeAll(where: { $0.name == nameToRemove })
                
            case "2":
                print("Введите название:")
                nameToRemove = readLine() ?? ""
                bookList.removeAll(where: { $0.name == nameToRemove })
                
            case "3":
                print("Введите название:")
                nameToRemove = readLine() ?? ""
                movieList.removeAll(where: { $0.name == nameToRemove })
                
            default:
                print("\tОшибка, попробуйте еще раз\n")
                multimediaManagerMenu()
            }
        }
        else {
            print("\tОшибка, попробуйте еще раз\n")
            multimediaManagerMenu()
        }
    }
    
    func multimediaManagerMenu() {
        print("\tОткрыть списки:")
        print("Музыка: введите 1")
        print("Книги: введите 2")
        print("Видео: введите 3")
        print("\tФункции:")
        print("Показать популярные: введите 4")
        print("Поиск по автору: введите 5")
        print("Поиск по названию: введите 6")
        print("Добавить мультимедию: Введите 7")
        print("Удалить мультимедию: Введите 8")
        let input = readLine()
        
        switch input {
        case "1":
            for music in musicList {
                print(musicInfoToString(currentMusic: music))
            }
            exit()
            
        case "2":
            for book in bookList {
                print(bookInfoToString(currentBook: book))
                
            }
            exit()
            
        case "3":
            for movie in movieList {
                print(movieInfoToString(currentMovie: movie))
            }
            exit()
            
        case "4":
            print("Музыка: введите 1")
            print("Книги: введите 2")
            print("Видео: введите 3")
            let temp = readLine()
            if checkSelection(input: temp ?? "-1") {
                getPopular(mediaType: mediaTypes(rawValue: temp!)!)
                exit()
            }
            else {
                print("\tОшибка, попробуйте еще раз\n")
                multimediaManagerMenu()
            }
            
        case "5":
            print("\tЧто будем искать?")
            print("Музыка: введите 1")
            print("Книги: введите 2")
            print("Видео: введите 3")
            let temp = readLine()
            if checkSelection(input: temp ?? "-1") {
                print("Введите имя автора")
                let authorName = readLine()
                searchNilChecker(input: authorName)
                mediaSearch(searchText: authorName!, mediaType: mediaTypes(rawValue: temp!)!, searchType: .author)
                exit()
            }
            else {
                print("\tОшибка, попробуйте еще раз\n")
                multimediaManagerMenu()
            }
            
        case "6":
            print("\tЧто будем искать?")
            print("Музыка: введите 1")
            print("Книги: введите 2")
            print("Видео: введите 3")
            let temp = readLine()
            if checkSelection(input: temp ?? "-1") {
                print("Введите имя автора")
                let authorName = readLine()
                searchNilChecker(input: authorName)
                mediaSearch(searchText: authorName!, mediaType: mediaTypes(rawValue: temp!)!, searchType: .name)
                exit()
            }
            else {
                print("\tОшибка, попробуйте еще раз\n")
                multimediaManagerMenu()
            }
            
        case "7":
            addMediaItemToList()
            
        case "8":
                removeMedia()
                exit()
        default:
            print("\tОшибка, попробуйте еще раз\n")
            multimediaManagerMenu()
        }
        
    }
}

let manager = multimediaManager()

func addRandomScore(item: mediaItem) {
    for _ in 1...40 {
        item.addScore(score: Int.random(in: 0...10))
    }
}

//Movies
let theShawshankRedemption = movie(name: "The Shawshank Redemption", author: "Frank Darabont", duration: 144)
let theGodfather = movie(name: "The Godfather", author: "Francis Ford Coppola", duration: 175)
let theDarkKnight = movie(name: "The Dark Knight", author: "Christopher Nolan", duration: 152 )
let schindlersList = movie(name: "Schindler's List", author: "Steven Spielberg", duration: 195 )

manager.movieList.append(theShawshankRedemption)
manager.movieList.append(theGodfather)
manager.movieList.append(theDarkKnight)
manager.movieList.append(schindlersList)

//Book
let iFeelBadAboutMyNeck = book(name: "I Feel Bad About My Neck", author: "Nora Ephron", bookGenre: .adventure , pageCount: 54)
let brokenGlass = book(name: "Broken Glass", author: "Alain Mabanckou ", bookGenre: .novel , pageCount: 101)
let aLittleLife = book(name: "A Little Life", author: "Hanya Yanagihara", bookGenre: .fantasy , pageCount: 59)

manager.bookList.append(iFeelBadAboutMyNeck)
manager.bookList.append(brokenGlass)
manager.bookList.append(aLittleLife)

//Music
let paintTheTownRed = music(name: "Paint The Town Red", author: "Doja Cat", duration: 134, genre: .hipHop)
let itGoesLikeNananaEdit = music(name: "(It Goes Like) Nanana (Edit)", author: "Peggy Gou", duration: 133, genre: .hipHop)
let strangers = music(name: "Strangers", author: "Kenya Grace", duration: 150, genre: .rap)
let tattoo = music(name: "Tattoo", author: "Loreen", duration: 151, genre: .classic)
let vampire = music(name: "Vampire", author: "Olivia Rodrigo", duration: 113, genre: .classic)

manager.musicList.append(paintTheTownRed)
manager.musicList.append(itGoesLikeNananaEdit)
manager.musicList.append(strangers)
manager.musicList.append(tattoo)
manager.musicList.append(vampire)

manager.multimediaManagerMenu()

