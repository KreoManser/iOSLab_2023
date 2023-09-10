import Foundation

// -----Default classes-----

class MediaItem {
    let name: String
    let author: String
    
    init(name: String, author: String) {
        self.name = name
        self.author = author
    }
    
    func toString() -> String {
        return "Name: \(name), author: \(author)\n"
    }
}

class Movie: MediaItem {
    let duration: Int
    let realeseCountry: String
    let movieGenre: MovieGenre
    
    init(name: String, author: String, movieGenre: MovieGenre, duration: Int, realeseCountry: String) {
        self.duration = duration
        self.realeseCountry = realeseCountry
        self.movieGenre = movieGenre
        super.init(name: name, author: author)
    }
    
    override func toString() -> String {
        return "Name: \(name), author: \(author), genre: \(movieGenre), duration: \(duration), realese country: \(realeseCountry)\n"
    }
}

class Music: MediaItem {
    let numberOfPlays: Int
    let isHaveTranslation: Bool
    let musicGenre: MusicGenre
    
    init(numberOfPlays: Int, isHaveTranslation: Bool, name: String, author: String, musicGenre: MusicGenre) {
        self.numberOfPlays = numberOfPlays
        self.isHaveTranslation = isHaveTranslation
        self.musicGenre = musicGenre
        super.init(name: name, author: author)
    }
    
    override func toString() -> String {
        return "Name: \(name), author: \(author), genre: \(musicGenre), number of plays: \(numberOfPlays), have translation: \(isHaveTranslation)\n"
    }
}

class Book: MediaItem {
    let numberOfPages: Int
    let bookGenre: BookGenre
    
    init(numberOfPages: Int, name: String, author: String, bookGenre: BookGenre) {
        self.numberOfPages = numberOfPages
        self.bookGenre = bookGenre
        super.init(name: name, author: author)
    }
    
    override func toString() -> String {
        return "Name: \(name), author: \(author), genre: \(bookGenre), number of pages: \(numberOfPages)\n"
    }
}




// -----Multimedia logic realization-----

class MultimediaManager: MultimediaFunctions {
    
    private var booksList: [Book] = []
    private var moviesList: [Movie] = []
    private var musicsList: [Music] = []
    
    func addMediaItem() {
        print("Choose media item")
        print("Book    Movie    Music")
        
        let mediaItemName = readLine()
        
        switch mediaItemName {
            
        case "Book":
            booksList.append(addBook())
            
        case "Movie":
            moviesList.append(addMovie())
            
        case "Music":
            musicsList.append(addMusic())
            
        default:
            if inputError() == "Yes" {
                addMediaItem()
            }
        }
        
        print("It's done!")
        print()
    }
    
    func deleteMediaItem() {
        var flag = false
        
        print("Choose media item")
        print("Book    Movie    Music")
        
        let mediaItemName = readLine()
        
        switch mediaItemName {
            
        case "Book":
            print("Enter book's name: ")
            let name = readLine() ?? ""
            
            for i in 0 ..< booksList.count {
                if booksList[i].name == name {
                    booksList.remove(at: i)
                    flag = true
                    break
                }
            }
            
        case "Movie":
            print("Enter movie's name: ")
            let name = readLine() ?? ""
            
            for i in 0 ..< moviesList.count {
                if moviesList[i].name == name {
                    moviesList.remove(at: i)
                    flag = true
                    break
                }
            }
            
        case "Music":
            print("Enter music's name: ")
            let name = readLine() ?? ""
            
            for i in 0 ..< musicsList.count {
                if musicsList[i].name == name {
                    musicsList.remove(at: i)
                    flag = true
                    break
                }
            }
            
        default:
            if inputError() == "Yes"{
                deleteMediaItem()
            }
        }
        if flag {
            print("It's done!")
            print()
        } else {
            if inputError() == "Yes"{
                deleteMediaItem()
            }
        }
    }
    
    func searchMediaItem() {
        print("Enter searcing string: ")
        let searchingString = readLine() ?? ""
        
        print("Choose media item")
        print("Book    Movie    Music")
        
        let mediaItemName = readLine()
        var searchingResult: [String] = []
        switch mediaItemName {
        case "Book":
            print("Select search param: ")
            print("Name    Author    Genre")
            let param = readLine() ?? ""
            
            switch param {
            case "Name":
                for item in booksList{
                    if item.name == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
            case "Author":
                for item in booksList{
                    if item.author == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
            case "Genre":
                for item in booksList{
                    if item.bookGenre.rawValue == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
                
            default:
                if inputError() == "Yes" {
                    searchMediaItem()
                }
            }
            
        case "Movie":
            print("Select search param: ")
            print("Name    Author    Genre")
            let param = readLine() ?? ""
            
            switch param {
            case "Name":
                for item in moviesList{
                    if item.name == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
            case "Author":
                for item in moviesList{
                    if item.author == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
            case "Genre":
                for item in moviesList{
                    if item.movieGenre.rawValue == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
                
            default:
                if inputError() == "Yes" {
                    searchMediaItem()
                }
            }
            
        case "Music":
            print("Select search param: ")
            print("Name    Author    Genre")
            let param = readLine() ?? ""
            
            switch param {
            case "Name":
                for item in musicsList{
                    if item.name == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
            case "Author":
                for item in musicsList{
                    if item.author == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
            case "Genre":
                for item in musicsList{
                    if item.musicGenre.rawValue == searchingString {
                        searchingResult.append(item.toString())
                    }
                }
                
            default:
                if inputError() == "Yes" {
                    searchMediaItem()
                }
            }
            
        default:
            if inputError() == "Yes" {
                searchMediaItem()
            }
        }
        
        if searchingResult.isEmpty {
            if inputError() == "Yes" {
                searchMediaItem()
            }
        } else {
            for item in searchingResult {
                print(item)
            }
        }
        print()
    }
    
    func printAllMediaItem() {
        print("Choose media item name: ")
        print("Book    Movie    Music")
        
        let name =  readLine() ?? ""
        
        switch name {
        case "Book":
            for item in booksList {
                print(item.toString())
            }
        case "Movie":
            for item in moviesList {
                print(item.toString())
            }
        case "Music":
            for item in musicsList {
                print(item.toString())
            }
        default:
            if inputError() == "Yes" {
                printAllMediaItem()
            }
        }
        print()
    }
    
}

func multiLibrary(multimediaManager: MultimediaManager) {
    
    
    while (true){
        goToMain()
        
        let numb = readLine() ?? ""
        
        switch numb {
        case "1":
            multimediaManager.searchMediaItem()
        case "2":
            multimediaManager.addMediaItem()
        case "3":
            multimediaManager.deleteMediaItem()
        case "4":
            multimediaManager.printAllMediaItem()
        case "5":
            print("Goodbye!")
            exit(0)
        default:
            if inputError() == "No" {
                print("Goodbye!")
                exit(0)
            }
            
        }
    }
}


// -----List of private functions and protocols-----

private func inputError() -> String {
    print("Oops...It seems that you entered incorrect information, do you want to continue?\n")
    
    let ans = readLine() ?? ""
    return ans
}

private func goToMain() {
    print("Welcome to main page of online multi library by Timur. There you can: ")
    print("1. search some media item by different params")
    print("2. add some media item")
    print("3. delete some media item")
    print("4. print all items from any group")
    print("5. reset online library")
    
}

private func addMovie() -> Movie{
    print("Enter movie's name: ")
    let name = readLine() ?? ""
    
    print("Enter movie's author: ")
    let author = readLine() ?? ""
    
    print("Enter movie's genre: ")
    print("Action    Adventure    Comedy    Drama")
    let genre = readLine() ?? ""
    
    print("Enter movie's duration: ")
    let duration = Int(readLine() ?? "") ?? 0
    
    print("Enter movie's realesed country: ")
    let realeseCountry = readLine() ?? ""
    
    return Movie(name: name, author: author, movieGenre: MovieGenre(rawValue: genre) ?? .fatal, duration: duration, realeseCountry: realeseCountry)
    
}

private func addBook() -> Book{
    print("Enter book's name: ")
    let name = readLine() ?? ""
    
    print("Enter book's author: ")
    let author = readLine() ?? ""
    
    print("Enter book's genre: ")
    print("Drama    Fable    Fantasy    Fiction")
    let genre = readLine() ?? ""
    
    print("Enter book's number of pages: ")
    let numberOfPages = Int(readLine() ?? "") ?? 0
    
    
    return Book(numberOfPages: numberOfPages, name: name, author: author, bookGenre: BookGenre(rawValue: genre) ?? .fatal)
    
}

private func addMusic() -> Music{
    print("Enter song's name: ")
    let name = readLine() ?? ""
    
    print("Enter song's author: ")
    let author = readLine() ?? ""
    
    print("Enter song's genre: ")
    print("Jazz    Rock    Folk    Hip Hop")
    let genre = readLine() ?? ""
    
    print("Enter song's nubmer of plays: ")
    let numberOfPlays = Int(readLine() ?? "") ?? 0
    
    print("Enter if song have translate: ")
    let translate = readLine() ?? ""
    let isHaveTranslate: Bool
    
    if translate == "Yes" {
        isHaveTranslate = true
    } else {
        isHaveTranslate = false
    }
    
    return Music(numberOfPlays: numberOfPlays, isHaveTranslation: isHaveTranslate, name: name, author: author, musicGenre: MusicGenre(rawValue: genre) ?? .fatal)
    
}

protocol MultimediaFunctions {
    
    func addMediaItem()
    func deleteMediaItem()
    func searchMediaItem ()
}


// ----List of enums----

enum MovieGenre: String {
    case action = "Action"
    case adventure = "Adventure"
    case comedy = "Comedy"
    case drama = "Drama"
    case fatal = "fatal"
    
}

enum BookGenre: String {
    case drama = "Drama"
    case fable = "Fable"
    case fantasy = "Fantasy"
    case fiction = "Fiction"
    case fatal = "fatal"
}

enum MusicGenre: String {
    case jazz = "Jazz"
    case rock = "Rock"
    case folk = "Folk"
    case hipHop = "Hip Hop"
    case fatal = "fatal"
}




// -----main part-----


let multimediaManager = MultimediaManager()

multiLibrary(multimediaManager: multimediaManager)
