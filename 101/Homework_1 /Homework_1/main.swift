import Foundation

protocol MediaItem {
    var title: String { get }
    var author: String { get }
    var ratings: [Double] { get set }
    
    mutating func addRating(_ rating: Double)
    func averageRating() -> Double
}

extension MediaItem {
    func averageRating() -> Double {
        if ratings.isEmpty {
            return 0.0
        }
        let totalRating = ratings.reduce(0.0, +)
        return totalRating / Double(ratings.count)
    }
}

struct Movie: MediaItem {
    var title: String
    var author: String
    var ratings: [Double] = []
    var director: String
    var releaseYear: Int
    
    mutating func addRating(_ rating: Double) {
        ratings.append(rating)
    }
}

struct Music: MediaItem {
    var title: String
    var author: String
    var ratings: [Double] = []
    var artist: String
    var album: String
    var year: Int
    
    mutating func addRating(_ rating: Double) {
        ratings.append(rating)
    }
}

struct Book: MediaItem {
    var title: String
    var author: String
    var ratings: [Double] = []
    var genre: String
    var publicationYear: Int
    
    mutating func addRating(_ rating: Double) {
        ratings.append(rating)
    }
}

class MediaLibraryManager {
    var mediaItems: [MediaItem] = []
    
    func addMediaItem(_ item: MediaItem) {
        mediaItems.append(item)
    }
    
    func removeMediaItem(_ item: MediaItem) {
        mediaItems.removeAll { $0.title == item.title && $0.author == item.author }
    }
    
    func searchMediaItemTitle(byTitle title: String) -> [MediaItem] {
        let results = mediaItems.filter { $0.title.contains(title) }
        return results
    }
    
    func searchMediaItemAuthor(byAuthor author: String) -> [MediaItem] {
        let results = mediaItems.filter { $0.author.contains(author) }
        return results
    }
    
    func getTopRatedMediaItems() -> [MediaItem] {
        let topRatedItems = mediaItems.filter { !$0.ratings.isEmpty }
        return topRatedItems.sorted(by: { $0.averageRating() > $1.averageRating() })
    }
}

var libraryManager = MediaLibraryManager()

while true {
    print("Выберите действие:")
    print("1. Добавить мультимедийный объект")
    print("2. Удалить мультимедийный объект")
    print("3. Поиск по названию")
    print("4. Поиск по автору")
    print("5. Выйти")
    
    if let choice = readLine(), let action = Int(choice) {
        switch action {
        case 1:
            print("Введите название:")
            let title = readLine() ?? ""
            print("Введите автора:")
            let author = readLine() ?? ""
            print("Выберите тип объекта (1 - Фильм, 2 - Музыка, 3 - Книга):")
            if let itemType = readLine(), let type = Int(itemType) {
                switch type {
                case 1:
                    print("Введите режиссера:")
                    let director = readLine() ?? ""
                    print("Введите год выпуска:")
                    if let yearString = readLine(), let year = Int(yearString) {
                        var movie = Movie(title: title, author: author, director: director, releaseYear: year)
                        print("Введите оценку (0-10):")
                        if let ratingString = readLine(), let rating = Double(ratingString) {
                            movie.addRating(rating)
                        }
                        libraryManager.addMediaItem(movie)
                        print("Фильм добавлен в библиотеку.\n")
                    }
                case 2:
                    print("Введите исполнителя:")
                    let artist = readLine() ?? ""
                    print("Введите альбом:")
                    let album = readLine() ?? ""
                    print("Введите год выпуска:")
                    if let yearString = readLine(), let year = Int(yearString) {
                        var music = Music(title: title, author: author, artist: artist, album: album, year: year)
                        print("Введите оценку (0-10):")
                        if let ratingString = readLine(), let rating = Double(ratingString) {
                            music.addRating(rating)
                        }
                        libraryManager.addMediaItem(music)
                        print("Музыка добавлена в библиотеку. \n")
                    }
                case 3:
                    print("Введите жанр:")
                    let genre = readLine() ?? ""
                    print("Введите год публикации:")
                    if let yearString = readLine(), let year = Int(yearString) {
                        var book = Book(title: title, author: author, genre: genre, publicationYear: year)
                        print("Введите оценку (0-10):")
                        if let ratingString = readLine(), let rating = Double(ratingString) {
                            book.addRating(rating)
                        }
                        libraryManager.addMediaItem(book)
                        print("Книга добавлена в библиотеку.\n")
                    }
                default:
                    print("Неверный тип объекта.\n")
                }
            }
            
        case 2:
            print("Введите название объекта для удаления:")
            let title = readLine() ?? ""
            print("Введите автора объекта для удаления:")
            let author = readLine() ?? ""
            
            let itemToDelete = libraryManager.mediaItems.first { $0.title == title && $0.author == author }
            
            if let itemToDelete = itemToDelete {
                libraryManager.removeMediaItem(itemToDelete)
                print("Объект удален из библиотеки.\n")
            } else {
                print("Объект с указанным названием и автором не найден.\n")
            }
            
        case 3:
            print("Введите название для поиска:")
            let title = readLine() ?? ""
            let results = libraryManager.searchMediaItemTitle(byTitle: title)
            if results.isEmpty {
                print("Объекты с указанным названием не найдены.\n")
            } else {
                print("\nРезультаты поиска по названию:")
                for item in results {
                    print("Название: \(item.title), Автор: \(item.author)\n")
                }
            }
            
        case 4:
            print("Введите автора для поиска:")
            let author = readLine() ?? ""
            let results = libraryManager.searchMediaItemAuthor(byAuthor: author)
            if results.isEmpty {
                print("Объекты с указанным автором не найдены.\n")
            } else {
                print("\nРезультаты поиска по автору:")
                for item in results {
                    print("Название: \(item.title), Автор: \(item.author)\n")
                }
            }
            
        case 5:
            exit(0)
            
        default:
            print("Неверный выбор. Пожалуйста, выберите действие снова.\n")
        }
    }
}
