import UIKit

enum TypeOfMediaItem: String {
    case Movie = "Фильм"
    case Music = "Музыка"
    case Book = "Книга"
}


protocol MediaItem {
    func getMediaItemName() -> String
    func getMediaItemAuthor() -> String
    func getMediaItemRating() -> Int
    func getMediaType() -> TypeOfMediaItem
}

struct Movie: MediaItem {
    private var nameOfMovie: String
    private var authorOfMovie: String
    private var raitingMovie: Int
    private var typeOfMediaItem: TypeOfMediaItem = .Movie
    
    init(nameOfMovie: String, authorOfMovie: String, raitingMovie: Int, typeOfMediaItem: TypeOfMediaItem) {
        self.nameOfMovie = nameOfMovie
        self.authorOfMovie = authorOfMovie
        self.raitingMovie = raitingMovie
        self.typeOfMediaItem = typeOfMediaItem
    }
    
    func getMediaItemName() -> String {
        return nameOfMovie
    }
    
    func getMediaItemAuthor() -> String {
        return authorOfMovie
    }
    
    func getMediaItemRating() -> Int {
        return raitingMovie
    }
    
    func getMediaType() -> TypeOfMediaItem {
        return typeOfMediaItem
    }
}

struct Music: MediaItem {
    private var nameOfMusic: String
    private var authorOfNusic: String
    private var raitingMusic: Int
    private var typeOfMediaItem: TypeOfMediaItem = .Music
    
    init(nameOfMusic: String, authorOfNusic: String, raitingMusic: Int, typeOfMediaItem: TypeOfMediaItem) {
        self.nameOfMusic = nameOfMusic
        self.authorOfNusic = authorOfNusic
        self.raitingMusic = raitingMusic
        self.typeOfMediaItem = typeOfMediaItem
    }
    
    func getMediaItemName() -> String {
        return nameOfMusic
    }
    
    func getMediaItemAuthor() -> String {
        return authorOfNusic
    }
    
    func getMediaItemRating() -> Int {
        return raitingMusic
    }
    
    func getMediaType() -> TypeOfMediaItem {
        return typeOfMediaItem
    }
}

struct Book: MediaItem {
    private var nameOfBook: String
    private var authorOfBook: String
    private var raitingBook: Int
    private var typeOfMediaItem: TypeOfMediaItem = .Book
    
    init(nameOfBook: String, authorOfBook: String, raitingBook: Int, typeOfMediaItem: TypeOfMediaItem) {
        self.nameOfBook = nameOfBook
        self.authorOfBook = authorOfBook
        self.raitingBook = raitingBook
        self.typeOfMediaItem = typeOfMediaItem
    }
    
    func getMediaItemName() -> String {
        return nameOfBook
    }
    
    func getMediaItemAuthor() -> String {
        return authorOfBook
    }
    
    func getMediaItemRating() -> Int {
        return raitingBook
    }
    
    func getMediaType() -> TypeOfMediaItem {
        return typeOfMediaItem
    }
}

protocol MediaManagerProtocol {
    func addMediaItem(_ item: MediaItem)
    func deleteMediaItem(_ item: MediaItem)
    func searchMediaItem(name: String) -> MediaItem?
    func searchMediaItem(author: String) -> MediaItem?
    func maxRating() -> MediaItem?
}

class MediaManager: MediaManagerProtocol {
    var arrayMovie: [Movie] = []
    var arrayMusic: [Music] = []
    var arrayBook: [Book] = []
    
    func addMediaItem(_ item: MediaItem) {
        switch item.getMediaType() {
        case .Movie:
            guard let movie = item as? Movie else {return}
            arrayMovie.append(movie)
        case .Music:
            guard let music = item as? Music else {return}
            arrayMusic.append(music)
        case .Book:
            guard let book = item as? Book else {return}
            arrayBook.append(book)
        }
        
    }
    
    func deleteMediaItem(_ item: MediaItem) {
        switch item.getMediaType() {
        case .Movie:
            guard let movie = item as? Movie else { break }
            
            for (index, movieInArray) in arrayMovie.enumerated() {
                if movie.getMediaItemName() == movieInArray.getMediaItemName() {
                    arrayMovie.remove(at: index)
                }
            }
            
        case .Music:
            guard let music = item as? Music else { break }
            for (index, musicInArray) in arrayMusic.enumerated() {
                if music.getMediaItemName() == musicInArray.getMediaItemName() {
                    arrayMusic.remove(at: index)
                }
            }
            
        case .Book:
            guard let book = item as? Book else { break }
            for (index, bookInArray) in arrayBook.enumerated() {
                if book.getMediaItemName() == bookInArray.getMediaItemName() {
                    arrayBook.remove(at: index)
                }
            }
        }
    }
    
    func searchMediaItem(name: String) -> MediaItem? {
        for movie in arrayMovie {
            if movie.getMediaItemName() == name {
                return movie
            }
        }
        
        for music in arrayMusic {
            if music.getMediaItemName() == name {
                return music
            }
        }
        
        for book in arrayBook {
            if book.getMediaItemName() == name {
                return book
            }
        }
        return nil
    }
    
    func searchMediaItem(author: String) -> MediaItem? {
        for movie in arrayMovie {
            if movie.getMediaItemAuthor() == author {
                return movie
            }
        }
        
        for music in arrayMusic {
            if music.getMediaItemAuthor() == author {
                return music
            }
        }
        
        for book in arrayBook {
            if book.getMediaItemAuthor() == author {
                return book
            }
        }
        return nil
    }
    
    func maxRating() -> MediaItem? {
        var mediaItem: MediaItem? = nil
        var count: Int = 0
        
        for movie in arrayMovie {
            if movie.getMediaItemRating() > count {
                count = movie.getMediaItemRating()
                mediaItem = movie
            }
        }
        
        for music in arrayMusic {
            if music.getMediaItemRating() > count {
                count = music.getMediaItemRating()
                mediaItem = music
            }
        }
        
        for book in arrayBook {
            if book.getMediaItemRating() > count {
                count = book.getMediaItemRating()
                mediaItem = book
            }
        }
        return mediaItem
    }
}

class Client {
    private let manager: MediaManagerProtocol = MediaManager()

    func addMediaItem(_ item: MediaItem) {
        manager.addMediaItem(item)
        print("Медиаобьект добавлен")
    }
    
    func deleteMediaItem(name: String) {
        guard let media = manager.searchMediaItem(name: name) else {
            print("Не найден объект по названию \(name)")
            return
        }
        manager.deleteMediaItem(media)
        print("Медиобьект удален")
    }
    
    func searchMediaItem(name: String) {
        guard let media = manager.searchMediaItem(name: name) else {
            print("Ничего не нашлось по названию: " + name)
            return
        }
        print("Произведен поиск по названию медиаобъекта: " + name)
        print("Автор медиаобъекта: " + media.getMediaItemAuthor())
        print("Рейтинг медиаобъекта: \(media.getMediaItemRating())")
        print("Тип медиобьекта: " + media.getMediaType().rawValue)
    }
    
    func searchMediaItem(author: String) {
        guard let media = manager.searchMediaItem(author: author) else {
            print("Ничего не нашлось по автору: " + author)
            return
        }
        print("Произведен поиск по автору медиаобъекта: " + author)
        print("Название медиаобъекта: " + media.getMediaItemName())
        print("Рейтинг медиаобъекта: \(media.getMediaItemRating())")
        print("Тип медиобьекта: " + media.getMediaType().rawValue)
    }
    
    func maxRating() {
        if let mediaWithMaxRating = manager.maxRating() {
            print("Медиаобъектом с наивысшим рейтингом является: " + mediaWithMaxRating.getMediaType().rawValue)
            print("Название медиаобъекта: " + mediaWithMaxRating.getMediaItemName())
            print("Автор медиаобъекта: " + mediaWithMaxRating.getMediaItemAuthor())
            print("Рейтинг медиаобъекта: \(mediaWithMaxRating.getMediaItemRating())")
        }
    }
}



let movie = Movie(nameOfMovie: "Муви", authorOfMovie: "Туралеев", raitingMovie: 5, typeOfMediaItem: .Movie)
let music = Music(nameOfMusic: "Сад", authorOfNusic: "Гио Пика", raitingMusic: 4, typeOfMediaItem: .Music)
let book = Book(nameOfBook: "Родной город", authorOfBook: "Пушкин", raitingBook: 3, typeOfMediaItem: .Book)

let client = Client()

client.addMediaItem(movie)
client.addMediaItem(music)
client.addMediaItem(book)


client.maxRating()

print("\n")

client.searchMediaItem(author: "Пушкин")

print("\n")

client.searchMediaItem(name: "Муви")
print("\n")
client.deleteMediaItem(name: "Муви")
print("\n")
client.searchMediaItem(name: "Муви")
print("\n")
client.searchMediaItem(author: "Пушкин")
print("\n")
client.maxRating()
