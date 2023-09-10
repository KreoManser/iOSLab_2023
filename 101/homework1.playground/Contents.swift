import Foundation

protocol Raiting{
    var raitingList: [Int] {get}
    var averageRating: Decimal {get}
    func addRaiting(raiting: Int)
}

class MediaItem: Raiting{
    private var privateRaitingList: [Int] = []
    var raitingList: [Int]{
        get{
            return privateRaitingList
        }
    }
    
    var averageRating: Decimal{
        get{
            if raitingList.isEmpty{
                return 0
            }
            var sum: Decimal = 0
            for i in raitingList{
                sum += Decimal(i)
            }
            return sum / Decimal(raitingList.count)
        }
        
    }
    
    func addRaiting(raiting: Int) {
        if raiting < 0{
            print("Оценка не сожет быть < 0")
        }
        else if raiting > 10{
            print("Оценка не сожет быть > 10")
        }
        else {
            privateRaitingList.append(raiting)
        }
    }
    
    var author: String
    var name: String
    
    init(author: String, name:String){
        self.author = author
        self.name = name
    }
}

class Movie: MediaItem{
    var filmDurationInMinutes: Int
    var filmGenre: FilmAndBookGenre
    
    init(name: String, author: String, filmDurationInMinutes: Int, filmGenre: FilmAndBookGenre){
        self.filmDurationInMinutes = filmDurationInMinutes
        self.filmGenre = filmGenre
        super.init(author: author, name: name)
    }
}

enum FilmAndBookGenre: String{
    case fantastic = "1"
    case romanic = "2"
    case horror = "3"
    case scientific = "4"
    case uncertain = "0"
}

class Music: MediaItem{
    var trackDurationInMinutes: Int
    var musicGenre: MusicGenre
    
    init(author: String, name: String, raiting: Decimal ,trackDurationInMinutes:Int, musicGenre: MusicGenre) {
        self.trackDurationInMinutes = trackDurationInMinutes
        self.musicGenre = musicGenre
        super.init(author: author, name: name)
    }
}

enum MusicGenre: String{
    case dramatic = "1"
    case hiphop = "2"
    case classic = "3"
    case club = "4"
    case uncertain = "0"
}

class Book: MediaItem{
    var countSheets: Int
    var bookGenre: FilmAndBookGenre
    
    init(author: String, name: String, raiting: Decimal ,countSheets: Int, bookGenre: FilmAndBookGenre) {
        self.countSheets = countSheets
        self.bookGenre = bookGenre
        super.init(author: author, name: name)
    }
}


class MediaManager{
    var films: [Movie] = []
    var musics: [Music] = []
    var books: [Book] = []
    
    func mediaManagerMenu(){
        print("Привет, добро пожаловать в MediaManger. Выбреите действие:")
        print("1. Вывести список музыки")
        print("2. Вывести список фильмов")
        print("3. Вывести список книг")
        print("4. Добавить медиа объект в коллекцию")
        print("5. Удалить объект из коллекции")
        print("6. Дать оценку объкту")
        print("7. Вывести топ объектов по мнению людей")
        print("8. Поиск по названию")
        print("9. Поиск по автору")
        print("10. Выход")

        if let input = readLine(){
            switch input{
            case "1":
                for i in 0..<musics.count{
                    print("Название: \(musics[i].name), автор: \(musics[i].author), длительность: \(musics[i].trackDurationInMinutes), рейтинг: \(musics[i].averageRating), Жанр: \(musics[i].musicGenre)")
                }
                
            case "2":
                for i in 0..<films.count{
                    print("Название: \(films[i].name), автор: \(films[i].author), длительность: \(films[i].filmDurationInMinutes), рейтинг: \(films[i].averageRating), Жанр: \(films[i].filmGenre)")
                }
                
            case "3":
                for i in 0..<books.count{
                    print("Название: \(books[i].name), автор: \(books[i].author), кол-во страниц: \(books[i].countSheets), рейтинг: \(books[i].averageRating), Жанр: \(books[i].bookGenre)")
                }
                
            case "4":
                mediaAdd()
                
            case "5":
                removeMedia()
                
            case "6":
                addRaiting()
                
            case "7":
                addRaiting()
                
            case "8":
                searchByAuthor()
                
            case "9":
                searchByName()
                
            case "10":
                break
                
            default:
                print("Простите, я вас не понял. Давайте попробуем еще?")
                mediaManagerMenu()
            }
        }
    }
    
    func popularMedia(){
        print("Выберите тип медиа:")
        print("1. Музыку")
        print("2. Фильм")
        print("3. Книгу")
        
        let type = readLine() ?? ""
        
        switch type{
        case "1":
            let sortedList = musics.sorted{$0.averageRating > $1.averageRating}
            print("Популярная музыка")
            for i in 0..<sortedList.count{
                print("Название: \(musics[i].name), автор: \(musics[i].author), длительность: \(musics[i].trackDurationInMinutes), рейтинг: \(musics[i].averageRating), Жанр: \(musics[i].musicGenre)")
            }
            mediaManagerMenu()
            
        case "2":
            let sortedList = films.sorted{$0.averageRating > $1.averageRating}
            print("Популярные фильмы")
            for i in 0..<sortedList.count{
                print("Название: \(films[i].name), автор: \(films[i].author), длительность: \(films[i].filmDurationInMinutes), рейтинг: \(films[i].averageRating), Жанр: \(films[i].filmGenre)")
            }
            mediaManagerMenu()
            
        case "3":
            let sortedList = books.sorted{$0.averageRating > $1.averageRating}
            print("Популярные книги")
            for i in 0..<sortedList.count{
                print("Название: \(books[i].name), автор: \(books[i].author), кол-во страниц: \(books[i].countSheets), рейтинг: \(books[i].averageRating), Жанр: \(books[i].bookGenre)")
            }
            mediaManagerMenu()
            
        default:
            print("Простите, я вас не понял. Давайте попробуем еще?")
            popularMedia()
        }
    
    }
    
    func removeMedia(){
        print("Что хотим удалить?")
        print("1. Музыку")
        print("2. Фильм")
        print("3. Книгу")
        print("Введите номер варианта:")
        
        let type = readLine()
        var name: String
        
        switch type{
        case "1":
            print("Введите название трека")
            name = readLine() ?? ""
            musics.removeAll(where: {$0.name == name})
            mediaManagerMenu()
            
            
        case "2":
            print("Введите название фильма")
            name = readLine() ?? ""
            films.removeAll(where: {$0.name == name})
            mediaManagerMenu()
            
        case "3":
            print("Введите название книги")
            name = readLine() ?? ""
            books.removeAll(where: {$0.name == name})
            mediaManagerMenu()
            
        default:
            print("Простите, я вас не понял. Давайте попробуем еще?")
            removeMedia()
        }
    }
    
    func addRaiting(){
        print("Введите название:")
        
        let name = readLine() ?? " "
        
        print("Введите тип объекта:")
        print("1. Музыка")
        print("2. Фильм")
        print("3. Книга")
        
        switch name{
        case "1":
            for i in 0..<musics.count{
                if musics[i].name == name{
                    print("Введите вашу оценку")
                    let raiting = readLine() ?? ""
                    musics[i].addRaiting(raiting: Int(raiting) ?? 0)
                }
            }
            print("Увы, я ничего тне нашел")
            mediaManagerMenu()
        case "2":
            for i in 0..<films.count{
                if films[i].name == name{
                    print("Введите вашу оценку")
                    let raiting = readLine() ?? ""
                    films[i].addRaiting(raiting: Int(raiting) ?? 0)
                }
            }
            print("Увы, я ничего тне нашел")
            mediaManagerMenu()
            
        case "3":
            for i in 0..<books.count{
                if books[i].name == name{
                    print("Введите вашу оценку")
                    let raiting = readLine() ?? ""
                    books[i].addRaiting(raiting: Int(raiting) ?? 0)
                    break
                }
            }
            print("Увы, я ничего тне нашел")
            mediaManagerMenu()
            
        default:
            print("Простите, я вас не понял. Давайте попробуем еще?")
            addRaiting()
        }
    }
    
    func mediaAdd() {
        var author: String
        var name: String
        let raiting: Decimal = 0
        var filmDurationInMinutes: Int
        var filmGenre: String
        var trackDurationInMinutes: Int
        var musicGenre: String
        var countSheets: Int
        var bookGenre: String
        
        print("Что хотим добавить?")
        print("1. Музыку")
        print("2. Фильм")
        print("3. Книгу")
        print("Введите номер варианта:")
        
        let type = readLine()
        
        switch type{
            
        case "1":
            print("Введите название музыки:")
            name = readLine() ?? ""
            
            print("Введите автора музыки:")
            author = readLine() ?? ""
            
            print("Сколько длится музыка в минутах:")
            trackDurationInMinutes = Int(readLine() ?? "") ?? 0
            
            print("Введите жанр музыки:")
            print("1 - драматичная:")
            print("2 - хип-хоп:")
            print("3 - класическая:")
            print("4 - клубная:")
            
            musicGenre = readLine() ?? ""
            musics.append(Music(author: author, name: name, raiting: raiting, trackDurationInMinutes: trackDurationInMinutes,
                                musicGenre: MusicGenre(rawValue: musicGenre ) ?? .uncertain))
            
            print("Вы добавили фильм")
            mediaManagerMenu()
        
        case "2":
            print("Введите название фильма:")
            name = readLine() ?? ""
            
            print("Введите автора фильма:")
            author = readLine() ?? ""
            
            print("Сколько длится фильм в минутах:")
            filmDurationInMinutes = Int(readLine() ?? "") ?? 0
            
            print("Введите жанр фильма:")
            print("1 - фантастика:")
            print("2 - романтика:")
            print("3 - ужасы:")
            print("4 - научный:")
            
            filmGenre = readLine() ?? ""
            films.append(Movie(name: name, author: author, filmDurationInMinutes: filmDurationInMinutes,
                                filmGenre: FilmAndBookGenre(rawValue: filmGenre ) ?? .uncertain))
            
            print("Вы добавили фильм")
            mediaManagerMenu()
            
        case "3":
            print("Введите название книги:")
            name = readLine() ?? ""
            
            print("Введите автора книги:")
            author = readLine() ?? ""
            
            print("Сколько страниц в книги:")
            countSheets = Int(readLine() ?? "") ?? 0
            
            print("Введите жанр книги:")
            print("1 - фантастика:")
            print("2 - романтика:")
            print("3 - ужасы:")
            print("4 - научный:")
            
            bookGenre = readLine() ?? ""
            books.append(Book(author: author, name: name, raiting: raiting, countSheets: countSheets,
                                bookGenre: FilmAndBookGenre(rawValue: bookGenre ) ?? .uncertain))
            
            print("Вы добавили фильм")
            mediaManagerMenu()
            
        default:
            print("Простите, я вас не понял. Давайте попробуем еще?")
            mediaAdd()
        }
        
    }
    
    func searchByName(){
        print("Введите назевани:")
        
        let name = readLine() ?? " "
        
        print("Среди чего будем искать?")
        print("1. Музыка")
        print("2. Фильмы")
        print("3. Книги")
        
        let input = readLine() ?? " "
        var counter = 0
        
        switch input{
        case "1":
            for i in 0..<musics.count{
                if(musics[i].name == name){
                    print("Вот что я нашел: Название: \(musics[i].name), автор: \(musics[0].author), длительность: \(musics[i].trackDurationInMinutes), рейтинг: \(musics[i].averageRating), Жанр: \(musics[i].musicGenre)")
                    counter += 1
                }
                if counter > 0{
                    mediaManagerMenu()
                }
                else{
                    print("Увы, я ничего ненашел :(")
                    mediaManagerMenu()
                }
            }
        case "2":
            for i in 0..<films.count{
                if(films[i].name == name){
                    print("Название: \(films[i].name), автор: \(films[i].author), длительность: \(films[i].filmDurationInMinutes), рейтинг: \(films[i].averageRating), Жанр: \(films[i].filmGenre)")
                    counter += 1
                }
                if counter > 0{
                    mediaManagerMenu()
                }
                else{
                    print("Увы, я ничего ненашел :(")
                    mediaManagerMenu()
                }
            }
        case "3":
            for i in 0..<books.count{
                if(books[i].name == name){
                    print("Название: \(books[i].name), автор: \(books[i].author), кол-во страниц: \(books[i].countSheets), рейтинг: \(books[i].averageRating), Жанр: \(books[i].bookGenre)")
                    counter += 1
                }
                if counter > 0{
                    mediaManagerMenu()
                }
                else{
                    print("Увы, я ничего ненашел :(")
                    mediaManagerMenu()
                }
            }
            
        default:
            print("Простите, я вас не понял. Давайте попробуем еще?")
            searchByName()
        }
        
    }
    
    func searchByAuthor(){
        print("Введите автора:")
        
        let author = readLine() ?? " "
        
        print("Среди чего будем искать?")
        print("1. Музыка")
        print("2. Фильмы")
        print("3. Книги")
        
        let input = readLine() ?? " "
        var counter = 0
        
        switch input{
        case "1":
            for i in 0..<musics.count{
                if(musics[i].author == author){
                    print("Вот что я нашел: Название: \(musics[i].name), автор: \(musics[0].author), длительность: \(musics[i].trackDurationInMinutes), рейтинг: \(musics[i].averageRating), Жанр: \(musics[i].musicGenre)")
                    counter += 1
                }
                if counter > 0{
                    mediaManagerMenu()
                }
                else{
                    print("Увы, я ничего ненашел :(")
                    mediaManagerMenu()
                }
            }
            
        case "2":
            for i in 0..<films.count{
                if(films[i].author == author){
                    print("Название: \(films[i].name), автор: \(films[i].author), длительность: \(films[i].filmDurationInMinutes), рейтинг: \(films[i].averageRating), Жанр: \(films[i].filmGenre)")
                    counter += 1
                }
                if counter > 0{
                    mediaManagerMenu()
                }
                else{
                    print("Увы, я ничего ненашел :(")
                    mediaManagerMenu()
                }
            }
            
        case "3":
            for i in 0..<books.count{
                if(books[i].author == author){
                    print("Название: \(books[i].name), автор: \(books[i].author), кол-во страниц: \(books[i].countSheets), рейтинг: \(books[i].averageRating), Жанр: \(books[i].bookGenre)")
                    counter += 1
                }
                if counter > 0{
                    mediaManagerMenu()
                }
                else{
                    print("Увы, я ничего ненашел :(")
                    mediaManagerMenu()
                }
            }
            
        default:
            print("Простите, я вас не понял. Давайте попробуем еще?")
            searchByAuthor()
        }
        
    }
}

let manager = MediaManager()

manager.films.append(Movie(name: "Название фильма 1", author: "Автор фильма 1", filmDurationInMinutes: 120, filmGenre: .fantastic))
manager.films.append(Movie(name: "Название фильма 2", author: "Автор фильма 2", filmDurationInMinutes: 90, filmGenre: .fantastic))
manager.films.append(Movie(name: "Название фильма 3", author: "Автор фильма 3", filmDurationInMinutes: 105, filmGenre: .fantastic))
manager.films.append(Movie(name: "Название фильма 4", author: "Автор фильма 4", filmDurationInMinutes: 150, filmGenre: .fantastic))
manager.films.append(Movie(name: "Название фильма 5", author: "Автор фильма 5", filmDurationInMinutes: 100, filmGenre: .fantastic))

manager.mediaManagerMenu()


