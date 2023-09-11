import Foundation

var manager = Manager()
func ui() {
    while true {
        print("What do you want to do? \noptions: (add, delete, search, evaluate, list sorted by rating)")
        let fun = readLine()
        switch fun{
        case "search":
            search()
        case "add":
            add()
        case "delete":
            delete()
        case "evaluate":
            evaluate()
        case "list sorted by rating":
            sortRating()
        default:
            print("Invalid operator")
            continue
        }
    }
}

func search(){
    print("Write the file name \nName: ")
    let name = readLine()
    let result = manager.search(name:name!)
    let index = result?.0
    let rating = result?.1.rating
    print("Your file has been found.\nIndex number \(String(index!)). Rating - \(rating!)\n")
}

func add(){
    print("Write the file name \nName: ")
    let name = readLine()
    print("select type (Movie,MediaItem,Music,Book) \nType: ")
    let type = readLine()
    print("Write the name of the author of the file\nAuthor: ")
    let author = readLine()
    
    switch type{
    case "Movie":
        let item = Types.movie(Movie(author: author!))
        let mmItem = MultiMediaItem(name: name!, rating: 0, item: item)
        manager.listItems.append(mmItem)
    case "MediaItem":
        let item = Types.mediaItem(MediaItem(author: author!))
        let mmItem = MultiMediaItem(name: name!, rating: 0, item: item)
        manager.listItems.append(mmItem)
    case "Music":
        let item = Types.music(Music(author: author!))
        let mmItem = MultiMediaItem(name: name!, rating: 0, item: item)
        manager.listItems.append(mmItem)
    case "Book":
        let item = Types.book(Book(author: author!))
        let mmItem = MultiMediaItem(name: name!, rating: 0, item: item)
        manager.listItems.append(mmItem)
    default:
        print("Invalid operator \n")
        return
    }
    print("item added successfully \n")
}

func delete(){
    print("Write the file name \nName: ")
    let name = readLine()
    manager.delete(name: name!)
    print("item deleted successfully \n")
}

func evaluate(){
    print("Write the file name \nName: ")
    let name = readLine()
    print("write the rating you want to give \nRating: ")
    let input = readLine()!
    let rating = Int(input)
    if rating != nil{
        manager.evaluate(name: name!, rating: rating!)
    } else {
        print("invalid number \n")
    }
    print("assessment successfully installed \n")
    
}

func sortRating(){
    manager.sortRating()
    for i in 0 ... manager.listSortRatingItems.count - 1 {
        print("\(i+1): \(manager.listSortRatingItems[i].name)")
    }
    print()
}
