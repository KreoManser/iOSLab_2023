//  main.swift
//  HomeWork_Manager

import Foundation

protocol MediaOption {
    func printName()
    func printAuthor()
    func printGenre()
    mutating func rate(score: Int)
}

struct Movie: Equatable, MediaOption {
    let name: String
    let author: String
    let genre: String
    
    var rating: Double?
    var raters: Int?
    var sumOfScores: Int?
    
    init(name: String, author: String, genre: String) {
        self.name = name
        self.author = author
        self.genre = genre
    }
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return ( (lhs.name == rhs.name) && (lhs.author == rhs.author) && (lhs.genre == rhs.genre) )
    }
    mutating func rate(score: Int) {
        if score > 5 || score < 1 {
            print("Ошибка. Необходимо ввести число от 1 до 5")
        }
        else {
            raters = (raters ?? 0) + 1
            sumOfScores = (sumOfScores ?? 0) + score
            if let raters, let sumOfScores {
                rating = Double(sumOfScores/raters)
            }
        }
    }
    func printName() {
        print("Название фильма: \(name)")
    }
    func printAuthor() {
        print("Автор: \(author)")
    }
    func printGenre() {
        print("Жанр: \(genre)")
    }
}

struct Music: Equatable, MediaOption  {
    let name: String
    let author: String
    let genre: String
    
    var rating: Double?
    var raters: Int?
    var sumOfScores: Int?
    
    init(name: String, author: String, genre: String) {
        self.name = name
        self.author = author
        self.genre = genre
    }
    static func == (lhs: Music, rhs: Music) -> Bool {
        return ( (lhs.name == rhs.name) && (lhs.author == rhs.author) && (lhs.genre == rhs.genre) )
    }
    mutating func rate(score: Int) {
        if score > 5 || score < 1 {
            print("Ошибка. Необходимо ввести число от 1 до 5")
        }
        else {
            raters = (raters ?? 0) + 1
            sumOfScores = (sumOfScores ?? 0) + score
            if let raters, let sumOfScores {
                rating = Double(sumOfScores/raters)
            }
        }
    }
    func printName() {
        print("Название музыки: \(name)")
    }
    func printAuthor() {
        print("Автор: \(author)")
    }
    func printGenre() {
        print("Жанр: \(genre)")
    }
}

struct Book: Equatable, MediaOption  {
    let name: String
    let author: String
    let genre: String
    
    var rating: Double?
    var raters: Int?
    var sumOfScores: Int?
    
    init(name: String, author: String, genre: String) {
        self.name = name
        self.author = author
        self.genre = genre
    }
    static func == (lhs: Book, rhs: Book) -> Bool {
        return ( (lhs.name == rhs.name) && (lhs.author == rhs.author) && (lhs.genre == rhs.genre) )
    }
    mutating func rate(score: Int) {
        if score > 5 || score < 1 {
            print("Ошибка. Необходимо ввести число от 1 до 5")
        }
        else {
            raters = (raters ?? 0) + 1
            sumOfScores = (sumOfScores ?? 0) + score
            if let raters, let sumOfScores {
                rating = Double(sumOfScores/raters)
            }
        }
    }
    func printName() {
        print("Название книги: \(name)")
    }
    func printAuthor() {
        print("Автор: \(author)")
    }
    func printGenre() {
        print("Жанр: \(genre)")
    }
}

class Manager {
    var movieArray: [Movie] = []
    var musicArray: [Music] = []
    var bookArray: [Book] = []
    
    //  добавление в библиотеку
    func addMovie(movie: Movie) {
        var flag = false
        if !movieArray.isEmpty {
            for m in movieArray {
                if m == movie {
                    flag = true
                }
            }
        }
        if flag {
            print("Фильм уже имеется")
        }
        else {
            movieArray.append(movie)
            print("Фильм добавлен")
        }
    }
    func addMusic(music: Music) {
        var flag = false
        if !musicArray.isEmpty {
            for m in musicArray {
                if m == music {
                    flag = true
                }
            }
        }
        if flag {
            print("Музыка уже имеется")
        }
        else {
            musicArray.append(music)
            print("Музыка добавлена")
        }
    }
    func addBook(book: Book) {
        var flag = false
        if !bookArray.isEmpty {
            for b in bookArray {
                if b == book {
                    flag = true
                }
            }
        }
        if flag {
            print("Книга уже имеется")
        }
        else {
            bookArray.append(book)
            print("Книга добавлена")
        }
    }
    //  удаление из библиотеки
    func removeMovie(movie: Movie) {
        var flag = false
        if !movieArray.isEmpty {
            for m in 0 ..< movieArray.count {
                if movieArray[m] == movie {
                    flag = true
                    movieArray.remove(at: m)
                    print("Фильм удален")
                    break
                }
            }
        }
        if flag {
            print("Ничего не найдено")
        }
        else {
            print("Библиотека пуста")
        }
    }
    func removeMusic(music: Music) {
        var flag = false
        if !musicArray.isEmpty {
            for m in 0 ..< musicArray.count {
                if musicArray[m] == music {
                    flag = true
                    musicArray.remove(at: m)
                    print("Музыка удалена")
                    break
                }
            }
        }
        if flag {
            print("Ничего не найдено")
        }
        else {
            print("Библиотека пуста")
        }
    }
    func removeBook(book: Book) {
        var flag = false
        if !bookArray.isEmpty {
            for b in 0 ..< bookArray.count {
                if bookArray[b] == book {
                    flag = true
                    bookArray.remove(at: b)
                    print("Книга удалена")
                    break
                }
            }
        }
        if flag {
            print("Ничего не найдено")
        }
        else {
            print("Библиотека пуста")
        }
    }
    //  поиск по названию
    func findMovieByName (name: String) {
        var foundMovie: [Movie] = []
        for m in 0 ..< movieArray.count {
            if movieArray[m].name == name {
                foundMovie.append(movieArray[m])
            }
        }
        if foundMovie.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По названию << \(name) >> найдено: ")
            for m in foundMovie {
                m.printName(); m.printAuthor(); m.printGenre()
            }
        }
    }
    func findMusicByName (name: String) {
        var foundMusic: [Music] = []
        for m in 0 ..< musicArray.count {
            if musicArray[m].name == name {
                foundMusic.append(musicArray[m])
            }
        }
        if foundMusic.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По названию << \(name) >> найдено: ")
            for m in foundMusic {
                m.printName(); m.printAuthor(); m.printGenre()
            }
        }
    }
    func findBookByName (name: String) {
        var foundBook: [Book] = []
        for b in 0 ..< bookArray.count {
            if bookArray[b].name == name {
                foundBook.append(bookArray[b])
            }
        }
        if foundBook.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По названию << \(name) >> найдено: ")
            for b in foundBook {
                b.printName(); b.printAuthor(); b.printGenre()
            }
        }
    }
    //  поиск по автору
    func findMovieByAuthor (author: String) {
        var foundMovie: [Movie] = []
        for m in 0 ..< movieArray.count {
            if movieArray[m].author == author {
                foundMovie.append(movieArray[m])
            }
        }
        if foundMovie.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По автору << \(author) >> найдено: ")
            for m in foundMovie {
                m.printName(); m.printAuthor(); m.printGenre()
            }
        }
    }
    func findMusicByAuthor (author: String) {
        var foundMusic: [Music] = []
        for m in 0 ..< musicArray.count {
            if musicArray[m].author == author {
                foundMusic.append(musicArray[m])
            }
        }
        if foundMusic.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По автору << \(author) >> найдено: ")
            for m in foundMusic {
                m.printName(); m.printAuthor(); m.printGenre()
            }
        }
    }
    func findBookByAuthor (author: String) {
        var foundBook: [Book] = []
        for b in 0 ..< bookArray.count {
            if bookArray[b].author == author {
                foundBook.append(bookArray[b])
            }
        }
        if foundBook.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По автору << \(author) >> найдено: ")
            for b in foundBook {
                b.printName(); b.printAuthor(); b.printGenre()
            }
        }
    }
    //  поиск по жанру
    func findMovieByGenre (genre: String) {
        var foundMovie: [Movie] = []
        for m in 0 ..< movieArray.count {
            if movieArray[m].genre == genre {
                foundMovie.append(movieArray[m])
            }
        }
        if foundMovie.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По жанру << \(genre) >> найдено: ")
            for m in foundMovie {
                m.printName(); m.printAuthor(); m.printGenre()
            }
        }
    }
    func findMusicByGenre (genre: String) {
        var foundMusic: [Music] = []
        for m in 0 ..< musicArray.count {
            if musicArray[m].genre == genre {
                foundMusic.append(musicArray[m])
            }
        }
        if foundMusic.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По жанру << \(genre) >> найдено: ")
            for m in foundMusic {
                m.printName(); m.printAuthor(); m.printGenre()
            }
        }
    }
    func findBookByGenre (genre: String) {
        var foundBook: [Book] = []
        for b in 0 ..< bookArray.count {
            if bookArray[b].genre == genre {
                foundBook.append(bookArray[b])
            }
        }
        if foundBook.isEmpty {
            print("Ничего не найдено")
        }
        else {
            print("По жанру << \(genre) >> найдено: ")
            for b in foundBook {
                b.printName(); b.printAuthor(); b.printGenre()
            }
        }
    }
    //    добавить оценку и установить новый рейтинг
    func setMovieRating(movie: Movie, score: Int) {
        if movieArray.contains(movie) {
            for m in 0 ..< movieArray.count {
                if movieArray[m] == movie {
                    movieArray[m].rate(score: score)
                }
            }
            movieArray.sort{ $0.rating ?? 0 >= $1.rating ?? 0 }
        }
        else {
            print("Такого фильма не имеется")
        }
    }
    func setMusicRating(music: Music, score: Int) {
        if musicArray.contains(music) {
            for m in 0 ..< musicArray.count {
                if musicArray[m] == music {
                    musicArray[m].rate(score: score)
                }
            }
            musicArray.sort{ $0.rating ?? 0 >= $1.rating ?? 0 }
        }
        else {
            print("Такой музыки не имеется")
        }
    }
    func setBookRating(book: Book, score: Int) {
        if bookArray.contains(book) {
            for b in 0 ..< bookArray.count {
                if bookArray[b] == book {
                    bookArray[b].rate(score: score)
                }
            }
            bookArray.sort{ $0.rating ?? 0 >= $1.rating ?? 0 }
        }
        else {
            print("Такой книги не имеется")
        }
    }
    //    получить топ 3 медиа
    func getTopMovie() {
        if movieArray.count >= 3 {
            for i in 0 ..< 3 {
                print("Топ 3 фильма")
                movieArray[i].printName()
                movieArray[i].printAuthor()
                movieArray[i].printGenre()
                print("")
            }
        }
        else {
            print("Пока топ не составлен")
        }
    }
    func getTopMusic() {
        if musicArray.count >= 3 {
            for i in 0 ..< 3 {
                print("Топ 3 музыки")
                musicArray[i].printName()
                musicArray[i].printAuthor()
                musicArray[i].printGenre()
                print("")
            }
        }
        else {
            print("Пока топ не составлен")
        }
    }
    func getTopBook() {
        if bookArray.count >= 3 {
            for b in 0 ..< 3 {
                print("Топ 3 книги")
                bookArray[b].printName()
                bookArray[b].printAuthor()
                bookArray[b].printGenre()
                print("")
            }
        }
        else {
            print("Пока топ не составлен")
        }
    }
}
var library = Manager()
while true {
    print("")
    print("Выберите действие:")
    print("")
    print("1.1 Добавить музыку")
    print("1.2 Удалить музыку")
    print("1.3 Найти музыку по названию")
    print("1.4 Найти музыку по автору")
    print("1.5 Найти музыку по жанру")
    print("1.6 Поставить оценку музыке")
    print("1.7 Получить топ 3 музыки")
    print("___________________")
    print("2.1 Добавить фильм")
    print("2.2 Удалить фильм")
    print("2.3 Найти фильм по названию")
    print("2.4 Найти фильм по автору")
    print("2.5 Найти фильм по жанру")
    print("2.6 Поставить оценку фильму")
    print("2.7 Получить топ 3 фильма")
    print("___________________")
    print("3.1 Добавить книгу")
    print("3.2 Удалить книгу")
    print("3.3 Найти книгу по названию")
    print("3.4 Найти книгу по автору")
    print("3.5 Найти книгу по жанру")
    print("3.6 Поставить оценку книге")
    print("3.7 Получить топ 3 книги")
    print("")
    
    if let choice = readLine() {
        switch choice {
            //      взаимодействия с музыкой
        case "1.1":
            print("Введите название музыки для добавления:")
            if let musicName = readLine() {
                print("Введите автора:")
                if let musicAuthor = readLine() {
                    print("Введите жанр:")
                    if let musicGenre = readLine() {
                        let music = Music(name: musicName, author: musicAuthor, genre: musicGenre)
                        library.addMusic(music: music)
                    }
                }
            }
        case "1.2":
            print("Введите название музыки для удаления:")
            if let musicName = readLine() {
                print("Введите автора:")
                if let musicAuthor = readLine() {
                    print("Введите жанр:")
                    if let musicGenre = readLine() {
                        let music = Music(name: musicName, author: musicAuthor, genre: musicGenre)
                        library.removeMusic(music: music)
                    }
                }
            }
        case "1.3":
            print("Введите название для поиска музыки:")
            if let musicName = readLine() {
                library.findMusicByName(name: musicName)
            }
        case "1.4":
            print("Введите автора для поиска музыки:")
            if let musicAuthor = readLine() {
                library.findMusicByAuthor(author: musicAuthor)
            }
        case "1.5":
            print("Введите жанр для поиска музыки:")
            if let musicGenre = readLine() {
                library.findMusicByGenre(genre: musicGenre)
            }
        case "1.6":
            print("Введите название музыки для оценки:")
            if let musicName = readLine() {
                print("Введите автора:")
                if let musicAuthor = readLine() {
                    print("Введите жанр:")
                    if let musicGenre = readLine() {
                        print("Поставьте оценку от 1 до 5:")
                        if let input = readLine() {
                            if let score = Int(input) {
                                var music = Music(name: musicName, author: musicAuthor, genre: musicGenre)
                                library.setMusicRating(music: music, score: score)
                                print("Спасибо за связь")
                            }
                        }
                    }
                }
            }
        case "1.7":
            library.getTopMusic()
            //      взаимодействия с фильмом
        case "2.1":
            print("Введите название фильма для добавления:")
            if let movieName = readLine() {
                print("Введите автора:")
                if let movieAuthor = readLine() {
                    print("Введите жанр:")
                    if let movieGenre = readLine() {
                        let movie = Movie(name: movieName, author: movieAuthor, genre: movieGenre)
                        library.addMovie(movie: movie)
                    }
                }
            }
        case "2.2":
            print("Введите название фильма для удаления:")
            if let movieName = readLine() {
                print("Введите автора:")
                if let movieAuthor = readLine() {
                    print("Введите жанр:")
                    if let movieGenre = readLine() {
                        let movie = Movie(name: movieName, author: movieAuthor, genre: movieGenre)
                        library.removeMovie(movie: movie)
                    }
                }
            }
        case "2.3":
            print("Введите название для поиска фильма:")
            if let movieName = readLine() {
                library.findMovieByName(name: movieName)
            }
        case "2.4":
            print("Введите автора для поиска фильма:")
            if let movieAuthor = readLine() {
                library.findMovieByAuthor(author: movieAuthor)
            }
        case "2.5":
            print("Введите жанр для поиска фильма:")
            if let movieGenre = readLine() {
                library.findMovieByGenre(genre: movieGenre)
            }
        case "2.6":
            print("Введите название фильма для оценки:")
            if let movieName = readLine() {
                print("Введите автора:")
                if let movieAuthor = readLine() {
                    print("Введите жанр:")
                    if let movieGenre = readLine() {
                        print("Поставьте оценку от 1 до 5:")
                        if let input = readLine() {
                            if let score = Int(input) {
                                var movie = Movie(name: movieName, author: movieAuthor, genre: movieGenre)
                                library.setMovieRating(movie: movie, score: score)
                                print("Спасибо за связь")
                            }
                        }
                    }
                }
            }
        case "2.7":
            library.getTopMovie()
            //      взаимодействия с книгой
        case "3.1":
            print("Введите название книги для добавления:")
            if let bookName = readLine() {
                print("Введите автора:")
                if let bookAuthor = readLine() {
                    print("Введите жанр:")
                    if let bookGenre = readLine() {
                        let book = Book(name: bookName, author: bookAuthor, genre: bookGenre)
                        library.addBook(book: book)
                    }
                }
            }
        case "3.2":
            print("Введите название книги для удаления:")
            if let bookName = readLine() {
                print("Введите автора:")
                if let bookAuthor = readLine() {
                    print("Введите жанр:")
                    if let bookGenre = readLine() {
                        let book = Book(name: bookName, author: bookAuthor, genre: bookGenre)
                        library.removeBook(book: book)
                    }
                }
            }
        case "3.3":
            print("Введите название книги для поиска:")
            if let bookName = readLine() {
                library.findBookByName(name: bookName)
            }
        case "3.4":
            print("Введите автора для поиска книги:")
            if let bookAuthor = readLine() {
                library.findBookByAuthor(author: bookAuthor)
            }
        case "3.5":
            print("Введите жанр для поиска книги:")
            if let bookGenre = readLine() {
                library.findBookByGenre(genre: bookGenre)
            }
        case "3.6":
            print("Введите название книги для оценки:")
            if let bookName = readLine() {
                print("Введите автора:")
                if let bookAuthor = readLine() {
                    print("Введите жанр:")
                    if let bookGenre = readLine() {
                        print("Поставьте оценку от 1 до 5:")
                        if let input = readLine() {
                            if let score = Int(input) {
                                var book = Book(name: bookName, author: bookAuthor, genre: bookGenre)
                                library.setBookRating(book: book, score: score)
                                print("Спасибо за связь")
                            }
                        }
                    }
                }
            }
        case "3.7":
            library.getTopBook()
        default:
            print("Неверный выбор")
        }
    }
}
