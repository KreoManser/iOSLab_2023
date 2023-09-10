//
//  main.swift
//  task
//
//  Created by Данил on 08.09.2023.
//

import Foundation

class MediaItem {
    let title: String
    let author: String
    let type: String

    init(title: String, author: String, type: String) {
        self.title = title
        self.author = author
        self.type = type
    }
    
    func to_string() -> String{
        return "";
    }
}

class Movie: MediaItem {
    let year: Int

    init(title: String, author: String, type: String, year: Int) {
        self.year = year
        super.init(title: title, author: author, type: type)
    }

    override func to_string() -> String {
        return "Тип медиа: \(type), название: \(title), режиссёр: \(author), год выпуска: \(year)"
    }
}

class Book: MediaItem {
    let year: Int

    init(title: String, author: String, type: String, year: Int) {
        self.year = year
        super.init(title: title, author: author, type: type)
    }

    override func to_string() -> String {
        return "Тип медиа: \(type), название: \(title), автор: \(author), год выпуска: \(year)"
    }
}

class Music: MediaItem {
    let album: String
    let year: Int

    init(title: String, author: String, type: String, album: String, year: Int) {
        self.album = album
        self.year = year
        super.init(title: title, author: author, type: type)
    }

    override func to_string() -> String {
        return "Тип медиа: \(type), альбом: \(album), песня: \(title), автор: \(author), год выпуска: \(year)"
    }
}

class MediaLibrary {
    var mediaItems: [MediaItem] = []

    func addMediaItem(item: MediaItem) {
        mediaItems.append(item)
        print("Мультимедийный объект успешно добавлен!")
    }

    func removeMediaItem(item: MediaItem) {
        if let index = mediaItems.firstIndex(where: { $0.title == item.title }) {
            mediaItems.remove(at: index)
            print("Мультимедийный объект успешно удален!")
        } else {
            print("Мультимедийный объект с таким названием не найден.")
        }
    }

    func searchMediaItem(byTitle title: String) -> [MediaItem] {
        let results = mediaItems.filter { $0.title.contains(title) }
        if results.isEmpty {
            print("Мультимедийные объекты с таким названием не найдены.")
        } else {
            print("Результаты поиска:")
            for item in results {
                print("Тип: \(item.type), Название: \(item.title), Автор: \(item.author)")
            }
        }
        return results
    }

    func searchMediaItem(byAuthor author: String) -> [MediaItem] {
        let results = mediaItems.filter { $0.author.contains(author) }
        if results.isEmpty {
            print("Мультимедийные объекты с таким автором не найдены.")
        } else {
            print("Результаты поиска:")
            for item in results {
                print("Тип: \(item.type), Название: \(item.title), Автор: \(item.author)")
            }
        }
        return results
    }

    func show() {
        for item in mediaItems {
            print(item.to_string())
        }
    }
}

let library = MediaLibrary()

while true {
    print("Выберите действие:")
    print("1. Добавить мультимедийный объект")
    print("2. Удалить мультимедийный объект")
    print("3. Поиск по названию")
    print("4. Поиск по автору")
    print("5. Выйти")

    if let choice = readLine(), let intChoice = Int(choice) {
        switch intChoice {
        case 1:
            print("Выберите тип мультимедийного объекта:")
            print("1. Фильм")
            print("2. Музыка")
            print("3. Книга")

            if let itemType = readLine(), let itemIntType = Int(itemType) {
                switch itemIntType {
                case 1:
                    print("Введите название фильма, автора и год выпуска:")
                    if let title = readLine(),
                       let author = readLine(),
                       let releaseYearStr = readLine(),
                       let releaseYear = Int(releaseYearStr) {
                        let movie = Movie(title: title, author: author, type: "фильм", year: releaseYear)
                        library.addMediaItem(item: movie)
                    }
                case 2:
                    print("Введите название песни, исполнителя, название альбома и год выпуска:")
                    if let title = readLine(),
                       let author = readLine(),
                       let album = readLine(),
                       let releaseYearStr = readLine(),
                       let releaseYear = Int(releaseYearStr) {
                        let music = Music(title: title, author: author, type: "музыка", album: album, year: releaseYear)
                        library.addMediaItem(item: music)
                    }
                case 3:
                    print("Введите название книги, автора и год выпуска:")
                    if let title = readLine(),
                       let author = readLine(),
                       let publicationYearStr = readLine(),
                       let publicationYear = Int(publicationYearStr) {
                        let book = Book(title: title, author: author, type: "книга", year: publicationYear)
                        library.addMediaItem(item: book)
                    }
                default:
                    print("Неверный выбор типа мультимедийного объекта.")
                }
            }
            library.show()
        case 2:
            print("Введите название мультимедийного объекта для удаления:")
            
            if let title = readLine() {
                let itemToRemove = MediaItem(title: title, author: "", type: "")
                library.removeMediaItem(item: itemToRemove)
            }
            library.show()
        case 3:
            print("Введите название для поиска:")
            if let title = readLine() {
                let _ = library.searchMediaItem(byTitle: title)
            }
        case 4:
            print("Введите автора для поиска:")
            if let author = readLine() {
                let _ = library.searchMediaItem(byAuthor: author)
            }
        case 5:
            exit(0)
        default:
            print("Неверный выбор. Пожалуйста, выберите действие из списка.")
        }
    }
}
