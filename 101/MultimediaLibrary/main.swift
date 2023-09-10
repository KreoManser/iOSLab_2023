//
//  main.swift
//  MultimediaLibrary
//
//  Created by Timur on 09.09.2023.
//

import Foundation

protocol MediaItem{
    var title: String {get set}
    var author: String {get set}
    var genre: String {get set}
    var rating: Int {get set}
    var marks: Int {get set}
    mutating func setRating(newRating: Int)
}

struct Movie : MediaItem{
    var id = 0
    var title = "Без названия"
    var author = "Неизвестен"
    var genre = "Неизвестный жанр"
    var durationInMinutes: Int //Длительность в минутах
    var marks = 0
    var rating = 0
    init(id: Int, title: String, author: String, durationInMinutes: Int, genre: String) {
        self.id = id
        self.title = title
        self.genre = genre
        self.durationInMinutes = durationInMinutes
        self.author = author
    }
    mutating func setRating(newRating: Int) {
        marks += 1
        rating = (rating + newRating)/marks
    }
}

struct Song : MediaItem{
    var id = 0
    var title = "Без названия"
    var author = "Неизвестен"
    var genre = "Неизвестный жанр"
    var durationInSeconds: Int //Длительность в секундах
    var marks = 0
    var rating = 0
    init(id: Int, title: String, author: String, durationInSeconds: Int, genre: String) {
        self.id = id
        self.title = title
        self.genre = genre
        self.durationInSeconds = durationInSeconds
        self.author = author
    }
    mutating func setRating(newRating: Int) {
        marks += 1
        rating = (rating + newRating)/marks
    }
}

struct Book : MediaItem{
    var id = 0
    var title = "Без названия"
    var author = "Неизвестен"
    var genre = "Неизвестный жанр"
    var pages: Int //Количество страниц
    var marks = 0
    var rating = 0
    init(id: Int, title: String, author: String, pages: Int, genre: String) {
        self.id = id
        self.title = title
        self.genre = genre
        self.pages = pages
        self.author = author
    }
    mutating func setRating(newRating: Int) {
        marks += 1
        rating = (rating + newRating)/marks
    }
}

class MediaManager{
    var songStorage = [Song]()
    var movieStorage = [Movie]()
    var bookStorage = [Book]()
    private var counter = 0
    func showConsoleMenu(){
        print("Это главное меню!")
        print("Посмотреть мультимедиа: ")
        print("1. Фильмы")
        print("2. Музыка")
        print("3. Книги")
        print("Действия с мультимедиа")
        print("4. Добавить")
        print("5. Удалить")
        print("6. Поиск")
        print("7. Оценить мультимедиа")
        print("8. Список лучших мультимедиа")
        let input = readLine() ?? "0"
        switch(input){
        case "1":
            print("Вот список фильмов: ")
            movieStorage.forEach({print($0)})
            goToMainMenu()
        case "2":
            print("Вот список песен: ")
            songStorage.forEach({print($0)})
            goToMainMenu()
        case "3":
            print("Вот список книг: ")
            bookStorage.forEach({print($0)})
            goToMainMenu()
        case "4":
            addNewItem()
        case "5":
            deleteItems()
        case "6":
            findItems()
        case "7":
            setRatingToItems()
            goToMainMenu()
        case "8":
            showBestByRatings()
            goToMainMenu()
        default:
            returnToMenuError()
        }
    }
    private func returnToMenuError(){
        print("Возникла ошибка, введите любой текст чтобы продолжить")
        readLine()
        showConsoleMenu()
    }
    func addNewItem(){
        print("Что хотите добавить?")
        print("1. Фильм")
        print("2. Песню")
        print("3. Книгу")
        switch(readLine()){
        case "1":
            print("Введите название")
            let title = readLine() ?? ("Без названия")
            print("Введите режиссера")
            let author = readLine() ?? ("Неизвестен")
            print("Введите жанр")
            let genre = readLine() ?? ("Неизвестный жанр")
            print("Введите длительность в минутах")
            let duration = Int(readLine() ?? "0") ?? 0
            addMovie(newMovie: Movie(id: counter, title: title, author: author, durationInMinutes: duration, genre: genre))
            counter += 1
            print("Фильм добавлен")
            goToMainMenu()
        case "2":
            print("Введите название")
            let title = readLine() ?? ("Без названия")
            print("Введите исполнителя")
            let author = readLine() ?? ("Неизвестен")
            print("Введите жанр")
            let genre = readLine() ?? ("Неизвестный жанр")
            print("Введите длительность в секундах")
            let duration = Int(readLine() ?? "0") ?? 0
            addSong(newSong: Song(id: counter, title: title, author: author, durationInSeconds: duration, genre: genre))
            print("Песня добавлена")
            counter += 1
            goToMainMenu()
        case "3":
            print("Введите название")
            let title = readLine() ?? ("Без названия")
            print("Введите писателя")
            let author = readLine() ?? ("Неизвестен")
            print("Введите жанр")
            let genre = readLine() ?? ("Неизвестный жанр")
            print("Введите количество страниц")
            let duration = Int(readLine() ?? "0") ?? 0
            addBook(newBook: Book(id: counter, title: title, author: author, pages: duration, genre: genre))
            counter += 1
            print("Книга добавлена")
            goToMainMenu()
        default:
            returnToMenuError()
        }
    }
    func deleteItems(){
        print("Что нужно удалить?")
        print("1. Фильм")
        print("2. Песню")
        print("3. Книгу")
        switch(readLine()){
        case "1":
            print("1. Удалить по названию")
            print("2. Удалить по автору")
            switch(readLine()){
            case "1":
                print("Введите название: ")
                deleteMovieByName(movieToDelete: readLine() ?? "-")
                goToMainMenu()
            case "2":
                print("Введите режиссера: ")
                deleteMoviesByDirector(movieToDelete: readLine() ?? "-")
                goToMainMenu()
            default:
                returnToMenuError()
            }
        case "2":
            print("1. Удалить по названию")
            print("2. Удалить по автору")
            switch(readLine()){
            case "1":
                print("Введите название: ")
                deleteSongByName(songToDelete: readLine() ?? "-")
                goToMainMenu()
            case "2":
                print("Введите исполнителя: ")
                deleteSongsBySinger(songToDelete: readLine() ?? "-")
                goToMainMenu()
            default:
                returnToMenuError()
            }
        case "3":
            print("1. Удалить по названию")
            print("2. Удалить по автору")
            switch(readLine()){
            case "1":
                print("Введите название: ")
                deleteBookByName(bookToDelete: readLine() ?? "-")
                goToMainMenu()
            case "2":
                print("Введите писателя: ")
                deleteBooksByWriter(bookToDelete: readLine() ?? "-")
                goToMainMenu()
            default:
                returnToMenuError()
            }
        default:
            returnToMenuError()
        }
    }
    func findItems(){
        print("Что нужно найти?")
        print("1. Фильм")
        print("2. Песню")
        print("3. Книгу")
        switch(readLine()){
        case "1":
            print("1. Найти по названию")
            print("2. Найти по автору")
            switch(readLine()){
            case "1":
                print("Введите название: ")
                findMovieByName(movieToFind: readLine() ?? "-")
                goToMainMenu()
            case "2":
                print("Введите режиссера: ")
                findMoviesByDirector(movieToFind: readLine() ?? "-")
                goToMainMenu()
            default:
                returnToMenuError()
            }
        case "2":
            print("1. Найти по названию")
            print("2. Найти по автору")
            switch(readLine()){
            case "1":
                print("Введите название: ")
                findSongByName(songToFind: readLine() ?? "-")
                goToMainMenu()
            case "2":
                print("Введите исполнителя: ")
                findSongBySinger(songToFind: readLine() ?? "-")
                goToMainMenu()
            default:
                returnToMenuError()
            }
        case "3":
            print("1. Найти по названию")
            print("2. Найти по автору")
            switch(readLine()){
            case "1":
                print("Введите название: ")
                findBookByName(bookToFind: readLine() ?? "-")
                goToMainMenu()
            case "2":
                print("Введите писателя: ")
                findBookByWriter(bookToFind: readLine() ?? "-")
                goToMainMenu()
            default:
                returnToMenuError()
            }
        default:
            returnToMenuError()
        }
    }
    func goToMainMenu(){
        print("Введите любой текст, чтобы вернуться в меню")
        readLine()
        showConsoleMenu()
    }
    func addMovie(newMovie : Movie){
        movieStorage.append(newMovie)
    }
    func addSong(newSong : Song){
        songStorage.append(newSong)
    }
    func addBook(newBook : Book){
        bookStorage.append(newBook)
    }
    func deleteMovieByName(movieToDelete : String){
        if !movieStorage.isEmpty{
            for i in 0...movieStorage.count-1{
                if movieStorage[i].title == movieToDelete{
                    print("Удалено: " + movieStorage[i].title)
                    movieStorage.remove(at: i)
                }
            }
        }
    }
    func deleteSongByName(songToDelete : String){
        if !songStorage.isEmpty{
            for i in 0...songStorage.count-1{
                if songStorage[i].title == songToDelete{
                    print("Удалено: " + songStorage[i].title)
                    songStorage.remove(at: i)
                }
            }
        }
    }
    func deleteBookByName(bookToDelete : String){
        if !bookStorage.isEmpty{
            for i in 0...bookStorage.count-1{
                if bookStorage[i].title == bookToDelete{
                    print("Удалено: " + bookStorage[i].title)
                    bookStorage.remove(at: i)
                }
            }
        }
    }
    func deleteMoviesByDirector(movieToDelete : String){
        if !movieStorage.isEmpty{
            for i in 0...movieStorage.count-1{
                if movieStorage[i].author == movieToDelete{
                    print("Удалено: " + movieStorage[i].title)
                    movieStorage.remove(at: i)
                }
            }
        }
    }
    func deleteSongsBySinger(songToDelete : String){
        if !songStorage.isEmpty{
            for i in 0...songStorage.count-1{
                if songStorage[i].author == songToDelete{
                    print("Удалено: " + songStorage[i].title)
                    songStorage.remove(at: i)
                }
            }
        }
    }
    func deleteBooksByWriter(bookToDelete : String){
        if !bookStorage.isEmpty{
            for i in 0...bookStorage.count-1{
                if bookStorage[i].author == bookToDelete{
                    print("Удалено: " + bookStorage[i].title)
                    bookStorage.remove(at: i)
                }
            }
        }
    }
    func findMovieByName(movieToFind : String){
        print("Найденные фильмы: ")
        if !movieStorage.isEmpty{
            for i in 0...movieStorage.count-1{
                if movieStorage[i].title == movieToFind{
                    print(movieStorage[i])
                }
            }
        }
    }
    func findSongByName(songToFind : String){
        print("Найденные песни: ")
        if !songStorage.isEmpty{
            for i in 0...songStorage.count-1{
                if songStorage[i].title == songToFind{
                    print(songStorage[i])
                }
            }
        }
    }
    func findBookByName(bookToFind : String){
        print("Найденные книги: ")
        if !bookStorage.isEmpty{
            for i in 0...bookStorage.count-1{
                if bookStorage[i].title == bookToFind{
                    print(bookStorage[i])
                }
            }
        }
    }
    func findMoviesByDirector(movieToFind : String){
        print("Найденные фильмы: ")
        if !movieStorage.isEmpty{
            for i in 0...movieStorage.count-1{
                if movieStorage[i].author == movieToFind{
                    print(movieStorage[i])
                }
            }
        }
    }
    func findSongBySinger(songToFind : String){
        print("Найденные песни: ")
        if !songStorage.isEmpty{
            for i in 0...songStorage.count-1{
                if songStorage[i].author == songToFind{
                    print(songStorage[i])
                }
            }
        }
    }
    func findBookByWriter(bookToFind : String){
        print("Найденные книги: ")
        if !bookStorage.isEmpty{
            for i in 0...bookStorage.count-1{
                if bookStorage[i].author == bookToFind{
                    print(bookStorage[i])
                }
            }
        }
    }
    func setRatingToItems(){
        print("Введите id элемента, который хотите оценить")
        let input = Int(readLine() ?? "-1") ?? -1
        if !movieStorage.isEmpty{
            for i in 0...movieStorage.count-1 {
                if movieStorage[i].id == input{
                    print("Введите оценку фильму \(movieStorage[i].title): ")
                    movieStorage[i].setRating(newRating: Int(readLine() ?? "-1" ) ?? -1)
                    return
                }
            }
        }
        if !songStorage.isEmpty{
            for i in 0...songStorage.count-1 {
                if songStorage[i].id == input{
                    print("Введите оценку песне \(songStorage[i].title): ")
                    songStorage[i].setRating(newRating: Int(readLine() ?? "-1" ) ?? -1)
                    return
                }
            }
        }
        if !bookStorage.isEmpty{
            for i in 0...bookStorage.count-1 {
                if bookStorage[i].id == input{
                    print("Введите оценку книге \(bookStorage[i].title): ")
                    bookStorage[i].setRating(newRating: Int(readLine() ?? "-1" ) ?? -1)
                    return
                }
            }
        }
    }
    func showBestByRatings(){
        let sortedMovies = movieStorage
            .sorted { $0.rating > $1.rating }
            .map {$0}
        let sortedSongs = songStorage
            .sorted { $0.rating > $1.rating }
            .map {$0}
        let sortedBooks = bookStorage
            .sorted { $0.rating > $1.rating }
            .map {$0}
        if !sortedMovies.isEmpty{
            print("Лучший фильм: \(sortedMovies[0])")
        }
        if !sortedSongs.isEmpty{
            print("Лучшая песня: \(sortedBooks[0])")
        }
        if !sortedBooks.isEmpty{
            print("Лучшая книга: \(sortedBooks[0])")
        }
    }
}
var ourManager = MediaManager()
ourManager.showConsoleMenu()
