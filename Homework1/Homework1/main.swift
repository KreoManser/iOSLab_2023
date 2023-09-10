import Foundation

protocol MediaItem {
    
    var title: String { get }
    var author: String { get }
    var rating: Int? {get set}
}

struct Movie: MediaItem {
    
    let title: String
    let author: String
    let releaseYear: Int
    var rating: Int?
    
}

struct Music: MediaItem {
    
    let title: String
    let author: String
    let genre: String
    let album: String
    var rating: Int?
}

struct Book: MediaItem {
    
    let title: String
    let author: String
    let genre: String
    var rating: Int?
}

class MultiMediaManager {
    var mediaItems: Array<MediaItem> = []
    
    func addMediaItem(item: MediaItem) {
        mediaItems.append(item)
    }
    
    func deleteMediaItem(item: MediaItem) {
        var index = 0
        for i in 0 ... mediaItems.count {
            if mediaItems[i].title == item.title {
                index = i
                break
            }
        }
        mediaItems.remove(at: index)
    }
    
    func SearchMediaItemByTitle(title: String) -> [MediaItem] {
        var items: Array<MediaItem> = []
        for i in mediaItems {
            if i.title == title {
                items.append(i)
            }
        }
        return items
    }
    
    func SearchMediaItemByAuthor(author: String) -> [MediaItem] {
        var items: Array<MediaItem> = []
        for i in mediaItems {
            if i.author == author {
                items.append(i)
            }
        }
        return items
    }
}

func displayMenu() {
    print("\nМеню:")
    print("1. Добавить фильм")
    print("2. Добавить музыку")
    print("3. Добавить книгу")
    print("4. Удалить мультимедийный объект")
    print("5. Поиск по названию")
    print("6. Поиск по автору/режиссеру")
    print("7. Показать наиболее популярные объекты")
    print("8. Оценить объект")
    print("9. Выйти")
    print("Выберите опцию (1-8):", terminator: " ")
}

func getUserInput() -> String {
    return readLine() ?? ""
}

let mediaManager = MultiMediaManager()

while true{
    displayMenu()
    
    if let choice = Int(getUserInput()) {
        switch choice {
        case 1:
            print("Введите название фильма:", terminator: " ")
            let title = getUserInput()
            print("Введите режиссера фильма:", terminator: " ")
            let author = getUserInput()
            print("Введите год выпуска фильма:", terminator: " ")
            if let realeaseYear = Int(getUserInput()) {
                let movie = Movie(title: title, author: author, releaseYear: realeaseYear)
                mediaManager.addMediaItem(item: movie)
                print("Фильм добавлен")
            }
            else {
                print("Неверный формат даты выхода")
            }
            
        case 2:
            print("Введите название песни:", terminator: " ")
            let title = getUserInput()
            print("Введите автора песни:", terminator: " ")
            let author = getUserInput()
            print("Введите альбом:", terminator: " ")
            let album = getUserInput()
            print("Введите жанр песни:", terminator: " ")
            let genre = getUserInput()
            let music = Music(title: title, author: author, genre: genre, album: album)
            mediaManager.addMediaItem(item: music)
            print("Песня добавлена")
            
        case 3:
            print("Введите название книги:", terminator: " ")
            let title = getUserInput()
            print("Введите автора книги:", terminator: " ")
            let author = getUserInput()
            print("Введите жанр книги:", terminator: " ")
            let genre = getUserInput()
            let book = Book(title: title, author: author, genre: genre)
            mediaManager.addMediaItem(item: book)
            print("Книга добавлена")
        
        case 4:
            print("Введите название объекта для удаления:", terminator: " ")
            let title = getUserInput()
            let items = mediaManager.SearchMediaItemByTitle(title: title)
            if items.isEmpty {
                print("Название не найдено")
            }
            else {
                for i in items {
                    mediaManager.deleteMediaItem(item: i)
                }
                print("Объект удален")
            }
            
        case 5:
            print("Введите название объекта:", terminator: " ")
            let title = getUserInput()
            let results = mediaManager.SearchMediaItemByTitle(title: title)
            if results.isEmpty {
                print("Название не найдено")
            }
            else {
                for item in results {
                    print("Название: \(item.title), Автор/Режиссер: \(item.author)")
                }
            }
            
        case 6:
            print("Введите имя автора:", terminator: " ")
            let author = getUserInput()
            let results = mediaManager.SearchMediaItemByAuthor(author: author)
            if results.isEmpty {
                print("Автор не найден")
            }
            else {
                for item in results {
                    print("Название: \(item.title), Автор/Режиссер: \(item.author)")
                }
            }
            
        case 7:
            print("НЕ РЕАЛИЗОВАЛ(")
            
        case 8:
            print("Введите название объекта:", terminator: " ")
            let title = getUserInput()
            var results = mediaManager.SearchMediaItemByTitle(title: title)
            if results.isEmpty {
                print("Название не найдено")
            }
            else {
                print("Оцените по шкале от 1 до 5")
                let rating = getUserInput()
                results[results.count - 1].rating = Int(rating)
                print("Оценка поставлена")

            }
            
        case 9:
            exit(0)
            
        default:
            print("Неверный выбор. Выберите 1 - 8")
        }
    }
    else {
        print("Неверный выбор. Выберите 1 - 8")
    }
}

