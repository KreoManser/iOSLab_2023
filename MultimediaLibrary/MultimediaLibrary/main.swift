import Foundation

var mediaLibrary = MediaManager()

while true {
    print("Выберите действие:")
    print("1. Добавить объект")
    print("2. Удалить объект")
    print("3. Поиск объекта по создателю")
    print("4. Поиск объекта по имени")
    
    let choice = readLine()
    
    if choice == "1" {
        let media = doMediaItem()
        mediaLibrary.add(media: media)
    } else if choice == "2" {
        let media = doMediaItem()
        mediaLibrary.remove(media: media)
    } else if choice == "3" {
        print("Введите имя создателя")
        let creator = readLine()
        mediaLibrary.searchByCreator(creator: creator!)
    } else if choice == "4" {
        print("Введите название")
        let name = readLine()
        mediaLibrary.searchByName(name: name!)
    } else {
        print("Пожалуйста, выберите корректную опцию")
    }
    
}

func doMediaItem() -> MediaItem {
    print("Введите название медии")
    let name = readLine()
    print("Введите имя создателя")
    let creator = readLine()
    print("Введите год выпуска")
    let year = readLine()
    print("Введите жанр")
    let genre = readLine()
    return MediaItem(name: name!, creator: creator!, year: year!, genre: genre!)
}

class MediaItem {
    let name: String
    let year: String
    let creator: String
    let genre: String
    var ratings: [Int] = []
    
    func addRating(rating: Int) {
        ratings.append(rating)
    }
    
    func averageRating() -> Double {
        if ratings.isEmpty {
            return 0.0
        }
        var ratingsSum = 0
        for rating in ratings {
            ratingsSum += rating
        }
        return Double(ratingsSum) / Double(ratings.count)
    }
    
    init(name: String, creator: String, year: String, genre: String) {
        self.name = name
        self.creator = creator
        self.year = year
        self.genre = genre
    }
}

class Movie: MediaItem {
    let director: String
    
    init(name: String, year: String, director: String, genre: String) {
        self.director = director
        super.init(name: name, creator: director, year: year, genre: genre)
    }
}

class Music: MediaItem {
    let artist: String
    
    init (name: String, year: String, artist: String, genre: String) {
        self.artist = artist
        super.init(name: name, creator: artist, year: year, genre: genre)
    }
}

class Book: MediaItem {
    let author: String
    
    init (name: String, year: String, author: String, genre: String) {
        self.author = author
        super.init(name: name, creator: author, year: year, genre: genre)
    }
}

class MediaManager {
    var mediaLibrary: [MediaItem]
    
    init (mediaLibrary: [MediaItem]) {
        self.mediaLibrary = mediaLibrary
    }
    
    init () {
        mediaLibrary = []
    }
    
    func add(media: MediaItem) {
        mediaLibrary.append(media)
        print("Добавлено")
    }
    
    func remove(media: MediaItem) {
        for (index, currentItem) in mediaLibrary.enumerated() {
            if media === currentItem {
                mediaLibrary.remove(at: index)
                print("Успешно удалено")
                break
            }
        }
        print("Не удалось найти")
    }
    
    func searchByName(name: String) -> MediaItem? {
        for media in mediaLibrary {
            if media.name == name {
                print("Найден элемент с таким именем")
                return media
            }
        }
        print("Не удалось найти")
        return nil
    }
    
    func searchByCreator(creator: String) -> MediaItem? {
        for media in mediaLibrary {
            if media.creator == creator {
                print("Найден элемент с таким именем")
                return media
            }
        }
        return nil
    }
    
    func findHighestRated() -> [MediaItem] {
        var highestRatedItems: [MediaItem] = []
        var highestRating: Double = 0.0

        for item in mediaLibrary {
            let average = item.averageRating()
            if average > highestRating {
                highestRating = average
                highestRatedItems = [item]
            } else if average == highestRating {
                highestRatedItems.append(item)
            }
        }

        return highestRatedItems
    }
}

// Задание с функциями высшего порядка

func filterLongWords(words: [String]) -> [String] {
    return words.filter {$0.count > 5}
}

func filterEvenNumbers(words: [Int]) -> [Int] {
    return words.filter {$0 % 2 == 0}
}
