//
//  main.swift
//  HomeWork1
//
//  Created by Faki Doosuur Doris on 07.09.2023.
//



import Foundation

//Media protocol
//Classes for book , audio, video
//Media manager class that can perfom operations(common attributes like name)

protocol MediaItem {
    
    var fileExtension: String { get }
    var title: String { get }
}


struct Book: MediaItem , CustomStringConvertible {
    var description: String{
        "\(author): \(title).\(fileExtension)"
    }
    var fileExtension: String = "pdf"
    
    var author: String
    
    var title: String
    
    init( author: String, title: String) {
        self.author = author
        self.title = title
    }
}
struct Music: MediaItem , CustomStringConvertible {
    var description: String{
        "\(artist): \(title).\(fileExtension)"
    }
    var fileExtension: String = "mp3"
    
    var artist: String
    
    var title: String
    
    init( artist: String, title: String) {
        self.artist = artist
        self.title = title
    }
}
struct Movie: MediaItem , CustomStringConvertible{
    var description: String{
        "\(director): \(title).\(fileExtension)"
    }
    var fileExtension: String = "mp4"
    
    var director: String
    
    var title: String
    
    init( director: String, title: String ) {
        self.director = director
        self.title = title
    }
}



class MediaManager{
    var mediaItems: [MediaItem] = []
    ///addition of items
    func addItem(_ Item: MediaItem){
        self.mediaItems.append(Item)
    }
    /// deleteByName removes mediaItem with the specified author's name and returns
    /// the number of deleted items.
    func deleteByTitle(_ name: String) -> Int {
        let oldCount = mediaItems.count
        mediaItems.removeAll { item in
            item.title == name
        }
        return  oldCount - mediaItems.count

    }
    ///deleteByTitle
    func deleteByFileExtension(_ fileExtension: String) -> Int {
        let oldcount = mediaItems.count
        mediaItems.removeAll{ item in
            item.fileExtension == fileExtension
        }
        return oldcount - mediaItems.count
    }
    ///searching objects by title
    func searchByName (_ title: String) -> [MediaItem]{
        mediaItems.filter{item in
            item.title == title
        }
    }
    ///searching objects by fileExtension
    func searchByFileExtension (_ fileExtension: String) -> [MediaItem]{
        mediaItems.filter{item in
            item.fileExtension == fileExtension
        }
        
    }
    
}


class Runner {
    /// Receiving user input
    private var manager = MediaManager()
    
    func run() {
        while true {
            let prompt = """
        a/A: add a new entry
        b/B: delete an existing entry
        p/P: print the media items
        q/Q: quit the application
        s/S: search the entry
        """
            print(prompt)
            guard let input = readLine()?.lowercased()
            else{
                break
            }
            print(input)
            switch input{
            case "a":
               promptForMediaType()
            case "b":
                deleteItems()
            case "p":
                print("\n\(manager.mediaItems)")
            case "s":
                searchItems()
            case "q":
                return
                
            default:
                print("\n[OUTPUT] unknown key, please try again...")
            }
        }
    }
    
    private func readInput(prompt: String = "> ") -> String? {
        print(prompt, terminator: "")
        return readLine()?.lowercased()
    }
    ///function to ask which media type the user wants to add to the MediaManager.
    private func promptForMediaType() {
        let prompt = """
                    Which kind of entry do you want to enter?
                    b/B: Books
                    m/M: Music
                    f/F:Movies
                    """
        print(prompt)
        guard let entry = readInput() else { return }
        guard let name = readInput(prompt: "Name: ") else { return }
        guard let title = readInput(prompt: "Title: ") else { return }
        switch entry {
        case "b":
            manager.addItem(Book(author: name, title: title))
        case "m":
            manager.addItem(Music(artist: name, title: title))
        case "f":
            manager.addItem(Movie(director: name, title: title))
            break
        default:
            print("Unknowm key, Please try again")
        }
    }
    
    ///function to search which media type the usesr wants to look for.
    private func searchItems(){
        let prompt = """
                     t/T: Search by title
                     f/F: Search by fileExtension
                     """
        print(prompt)
        guard let input = readInput() else { return }
        guard let query = readInput(prompt: "Query(?): ") else { return }
        var foundItems: [MediaItem]?
        switch input{
        case "t":
            foundItems = manager.searchByName(query)
        case "f":
            foundItems = manager.searchByFileExtension(query)
        default:
            print("Unknown key, Please try again!")
        }
        guard let foundItems = foundItems else { return }
        if foundItems.count == 0 {
            print("No item(s) found")
        } else {
            print("\(foundItems.count) item(s) found")
            print(foundItems)
        }
    }
    
    private func deleteItems(){
        let prompt = """
                     dt/DT: delete by title
                     dfe/DFE: delete by fileExtension
                     """
        print(prompt)
        guard let input = readInput() else { return }
        guard let query = readInput(prompt: "Query(?): ") else { return }
        var deletedItem:Int?
        switch input{
        case "dt":
           deletedItem = manager.deleteByTitle(query)
        case "dfe":
            deletedItem =  manager.deleteByFileExtension(query)
        default:
            print("Unknown key, Please try again!")
        }
        guard let deletedItem = deletedItem else { return }
        print("\(deletedItem) items(s) deleted")
    }
    
}


let runner = Runner()
runner.run()
