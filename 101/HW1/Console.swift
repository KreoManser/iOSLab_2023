//
//  Console.swift
//  HW1
//
//  Created by Alina on 14.09.2023.
//

class Console {
    let manager = LibraryManager()
    
    func start() {
        print("Welcome to the Media Library!")
        
        var shouldContinue = true
        
        while shouldContinue {
            print("Please select an option:")
            print("1. Music")
            print("2. Books")
            print("3. Movies")
            print("4. Exit")
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    handleMusicMenu()
                case "2":
                    handleBooksMenu()
                case "3":
                    handleMoviesMenu()
                case "4":
                    shouldContinue = false
                default:
                    print("Invalid choice. Please try again.")
                }
            }
        }
        
        print("Goodbye!")
    }
    
    func handleMusicMenu() {
        print("You are in the Music menu.")
        
        var shouldContinue = true
        
        while shouldContinue {
            print("Please select an option:")
            print("1. Search by title")
            print("2. Search by author")
            print("3. Add a music item")
            print("4. Remove a music item")
            print("5. Go back to main menu")
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    searchMusicByTitle()
                case "2":
                    searchMusicByAuthor()
                case "3":
                    addMusicItem()
                case "4":
                    removeMusicItem()
                case "5":
                    shouldContinue = false
                default:
                    print("Invalid choice. Please try again.")
                }
            }
        }
    }
    
    func handleBooksMenu() {
        print("You are in the Books menu.")
        
        var shouldContinue = true
        
        while shouldContinue {
            print("Please select an option:")
            print("1. Search by title")
            print("2. Search by author")
            print("3. Add a book item")
            print("4. Remove a book item")
            print("5. Go back to main menu")
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    searchBooksByTitle()
                case "2":
                    searchBooksByAuthor()
                case "3":
                    addBookItem()
                case "4":
                    removeBookItem()
                case "5":
                    shouldContinue = false
                default:
                    print("Invalid choice. Please try again.")
                }
            }
        }
    }
    
    func handleMoviesMenu() {
        print("You are in the Movies menu.")
        
        var shouldContinue = true
        
        while shouldContinue {
            print("Please select an option:")
            print("1. Search by title")
            print("2. Search by author")
            print("3. Add a movie item")
            print("4. Remove a movie item")
            print("5. Go back to main menu")
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    searchMoviesByTitle()
                case "2":
                    searchMoviesByAuthor()
                case "3":
                    addMovieItem()
                case "4":
                    removeMovieItem()
                case "5":
                    shouldContinue = false
                default:
                    print("Invalid choice. Please try again.")
                }
            }
        }
    }
    
    // Music menu methods
    func searchMusicByTitle() {
        print("Enter the music title:")
        let title = readLine() ?? ""
        
        let items = manager.searchMusicItemByTitle(title: title)
        
        if items.isEmpty {
            print("No music items found with the given title.")
        } else {
            for item in items {
                print(item)
            }
        }
    }
    
    func searchMusicByAuthor() {
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        let items = manager.searchMusicItemByAuthor(author: author)
        
        if items.isEmpty {
            print("No music items found with the given artist.")
        } else {
            for item in items {
                print(item)
            }
        }
    }
    
    func addMusicItem() {
        print("Enter the music title:")
        let title = readLine() ?? ""
        
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        print("Enter the year:")
        let year = readLine() ?? ""
        
        print("Enter the genre:")
        let genre = readLine() ?? ""
        
        print("Enter the language:")
        let language = readLine() ?? ""
        
        print("Enter the mood:")
        let mood = readLine() ?? ""
        
        let item = MusicItem(title: title, author: author, year: year, genre: genre, language: language, mood: mood)
        
        manager.addMediaItem(item: item)
        
        print("Music item added successfully.")
    }
    
    func removeMusicItem() {
        print("Enter the music title:")
        let title = readLine() ?? ""
        
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        print("Enter the year:")
        let year = readLine() ?? ""
        
        print("Enter the genre:")
        let genre = readLine() ?? ""
        
        print("Enter the language:")
        let language = readLine() ?? ""
        
        print("Enter the mood:")
        let mood = readLine() ?? ""
        
        let item = MusicItem(title: title, author: author, year: year, genre: genre, language: language, mood: mood)
        
        manager.removeMediaItem(item: item)
        
        print("Music item removed successfully.")
    }
    
    // Books menu methods
    func searchBooksByTitle() {
        print("Enter the book title:")
        let title = readLine() ?? ""
        
        let items = manager.searchBookItemByTitle(title: title)
        
        if items.isEmpty {
            print("No book items found with the given title.")
        } else {
            for item in items {
                print(item)
            }
        }
    }
    
    func searchBooksByAuthor() {
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        let items = manager.searchBookItemByAuthor(author: author)
        
        if items.isEmpty {
            print("No book items found with the given author.")
        } else {
            for item in items {
                print(item)
            }
        }
    }
    
    func addBookItem() {
        print("Enter the book title:")
        let title = readLine() ?? ""
        
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        print("Enter the year:")
        let year = readLine() ?? ""
        
        print("Enter the genre:")
        let genre = readLine() ?? ""
        
        print("Enter the language:")
        let language = readLine() ?? ""
        
        print("Enter the mood:")
        let mood = readLine() ?? ""
        
        let item = BookItem(title: title, author: author, year: year, genre: genre, language: language, mood: mood)
        
        manager.addMediaItem(item: item)
        
        print("Book item added successfully.")
    }
    
    func removeBookItem() {
        print("Enter the book title:")
        let title = readLine() ?? ""
        
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        print("Enter the year:")
        let year = readLine() ?? ""
        
        print("Enter the genre:")
        let genre = readLine() ?? ""
        
        print("Enter the language:")
        let language = readLine() ?? ""
        
        print("Enter the mood:")
        let mood = readLine() ?? ""
        
        let item = BookItem(title: title, author: author, year: year, genre: genre, language: language, mood: mood)
        
        manager.removeMediaItem(item: item)
        
        print("Book item removed successfully.")
    }
    
    // Movies menu methods
    func searchMoviesByTitle() {
        print("Enter the movie title:")
        let title = readLine() ?? ""
        
        let items = manager.searchMovieItemByTitle(title: title)
        
        if items.isEmpty {
            print("No movie items found with the given title.")
        } else {
            for item in items {
                print(item)
            }
        }
    }
    
    func searchMoviesByAuthor() {
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        let items = manager.searchMovieItemByAuthor(author: author)
        
        if items.isEmpty {
            print("No movie items found with the given author.")
        } else {
            for item in items {
                print(item)
            }
        }
    }
    
    func addMovieItem() {
        print("Enter the movie title:")
        let title = readLine() ?? ""
        
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        print("Enter the year:")
        let year = readLine() ?? ""
        
        print("Enter the genre:")
        let genre = readLine() ?? ""
        
        print("Enter the language:")
        let language = readLine() ?? ""
        
        print("Enter the duration:")
        let duration = readLine() ?? ""
        
        let item = MovieItem(title: title, author: author, year: year, genre: genre, language: language, duration: duration)
        
        manager.addMediaItem(item: item)
        
        print("Movie item added successfully.")
    }
    
    func removeMovieItem() {
        print("Enter the movie title:")
        let title = readLine() ?? ""
        
        print("Enter the author name:")
        let author = readLine() ?? ""
        
        print("Enter the year:")
        let year = readLine() ?? ""
        
        print("Enter the genre:")
        let genre = readLine() ?? ""
        
        print("Enter the language:")
        let language = readLine() ?? ""
        
        print("Enter the duration:")
        let duration = readLine() ?? ""
        
        let item = MovieItem(title: title, author: author, year: year, genre: genre, language: language, duration: duration)
        
        manager.removeMediaItem(item: item)
        
        print("Movie item removed successfully.")
    }
}

