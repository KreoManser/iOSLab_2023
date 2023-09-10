class Library {
    struct MediaItem: Hashable {
        var name: String
        var category: String

        init(name: String, category: String) {
            self.name = name
            self.category = category
        }
    }

    struct Movie {
        let name: String
        let director: String
        let year: Int

        init(name: String, director: String, year: Int) {
            self.name = name
            self.director = director
            self.year = year
        }
    }

    struct Music {
        let name: String
        let musician: String
        let year: Int

        init(name: String, musician: String, year: Int) {
            self.name = name
            self.musician = musician
            self.year = year
        }
    }

    struct Book {
        let name: String
        let author: String
        let year: Int

        init(name: String, author: String, year: Int) {
            self.name = name
            self.author = author
            self.year = year
        }
    }
}

class LibraryManager: Library {
    var mediaLibrary: [MediaItem: Any] = [:]

    func addMediaItem(_ item: MediaItem, data: Any) {
        mediaLibrary[item] = data
    }
    
    func removeMediaItem(_ item: MediaItem) {
            mediaLibrary[item] = nil
        }

    func searchMediaItems(byTitle title: String) -> [MediaItem] {
        let items = mediaLibrary.keys.filter { $0.name.lowercased().contains(title.lowercased()) }
        return Array(items)
    }

    func listAllMediaItems() {
        print("-----------------------")
        for (item, data) in mediaLibrary {
            print("Категория: \(item.category) \nНазвание: \(item.name)")
            if let movie = data as? Movie {
                print("Режиссёр: \(movie.director) \nГод Выпуска: \(movie.year)")
                
            } else if let music = data as? Music {
                print("Композитор: \(music.musician) \nГод релиза: \(music.year)")
                
            } else if let book = data as? Book {
                print("Автор: \(book.author) \nДата издания: \(book.year)")
            }
            print("-----------------------")
        }
    }

    func runLibraryApp() {
        while true {
            print("-----------------------")
            print("Меню:")
            print("1. Добавить мультимедийный объект")
            print("2. Удалить мультимедийный объект")
            print("3. Вывести всю библиотеку")
            print("4. Поиск мультимедийного объекта по названию")
            print("5. Выйти ")
            print("-----------------------")
            if let choice = readLine(), let menuChoice = Int(choice) {
                switch menuChoice {
                case 1:
                    print("Введите название мультимедийного объекта:")
                    if let name = readLine() {
                        print("Выберите категорию (1 - Movie, 2 - Music, 3 - Book):")
                        
                        if let categoryChoice = readLine(), let categoryInt = Int(categoryChoice), let category = getCategoryFromChoice(categoryInt) {
                            switch category {
                            case "Movie":
                                addMovie(name: name)
                            case "Music":
                                addMusic(name: name)
                            case "Book":
                                addBook(name: name)
                            default:
                                print("Неверный выбор категории.")
                            }
                        } else {
                            print("Неверный выбор категории.")
                        }
                    }
                case 2:
                    print("Введите название файла для удаления:")
                    if let name = readLine() {
                        let items = mediaLibrary.keys.filter { $0.name.lowercased() == name.lowercased() }
                        
                        if !items.isEmpty {
                            for (index, item) in items.enumerated() {
                                print("\(index + 1). \(item.name) (\(item.category))")
                            }
                            print("Выберите файл, который хотите удалить (введите номер):")
                            
                            if let choice = readLine(), let selectedIndex = Int(choice), selectedIndex > 0, selectedIndex <= items.count {
                                let selectedItem = items[selectedIndex - 1]
                                removeMediaItem(selectedItem)
                                print("Мультимедийный объект удален из библиотеки.")
                            }
                        } else {
                            print("Мультимедийный объект с таким названием не найден.")
                        }
                    }
                case 3:
                    listAllMediaItems()
                
                case 4:
                    print("Введите название для поиска:")
                    if let title = readLine() {
                        let items = searchMediaItems(byTitle: title)
                        
                        if !items.isEmpty {
                            print("Найдены следующие файлы по запросу \(title):")
                            
                            for item in items {
                                print("\(item.name) (\(item.category))")
                            }
                            
                        } else {
                            print("Мультимедийных объектов с названием \(title) не найдено.")
                        }
                    }
                case 5:
                    return
                    
                default:
                    print("Неверный выбор. Попробуйте ещё раз.")
                }
            }
        }
    }

    func getCategoryFromChoice(_ choice: Int) -> String? {
        switch choice {
        case 1:
            return "Movie"
        case 2:
            return "Music"
        case 3:
            return "Book"
            
        default:
            return nil
        }
    }

    
    func addMovie(name: String) {
        print("Введите режиссера:")
        if let director = readLine() {
            print("Введите год:")
            
            if let yearInput = readLine(), let year = Int(yearInput) {
                let movie = Movie(name: name, director: director, year: year)
                let mediaItem = MediaItem(name: name, category: "Movie")
                addMediaItem(mediaItem, data: movie)
                
                print("Файл \(name) добавлен в библиотеку(Movie).")
            }
        }
    }

    func addMusic(name: String) {
        print("Введите музыканта:")
        if let musician = readLine() {
            print("Введите год:")
            
            if let yearInput = readLine(), let year = Int(yearInput) {
                let music = Music(name: name, musician: musician, year: year)
                let mediaItem = MediaItem(name: name, category: "Music")
                addMediaItem(mediaItem, data: music)
                
                print("Файл \(name) добавлен в библиотеку(Music).")
            }
        }
    }

    func addBook(name: String) {
        print("Введите автора:")
        
        if let author = readLine() {
            print("Введите год выпуска:")
            if let yearInput = readLine(), let year = Int(yearInput) {
                let book = Book(name: name, author: author, year: year)
                let mediaItem = MediaItem(name: name, category: "Book")
                addMediaItem(mediaItem, data: book)
                
                print("Файл \(name) добавлен в библиотеку(Book).")
            }
        }
    }
}

let libraryManager = LibraryManager()
libraryManager.runLibraryApp()

// Не успел реализовать поиск по другим критериям(по категории, автору и году)
