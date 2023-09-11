import Foundation

enum Types {
    case music(Music)
    case movie(Movie)
    case book(Book)
    case mediaItem(MediaItem)
}

struct MediaItem{
    var author: String
}

struct Movie{
    var author: String
}
    
struct Music{
    var author: String
}

struct Book {
    var author: String
}
