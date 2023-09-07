import UIKit
import Foundation


class Media{
    var name: String
    var author: String
    var grade: Int
    
    init(name:String, author:String){
        self.name = name
        self.author = author
        self.grade = 0
    }

    func getName() -> String{
        return name
    }
    
    func getAuthor()-> String{
        return author
    }
    
    func getGrade()-> Int{
        return grade
    }
    
    func setGrade(grade: Int){
        self.grade = grade
    }
    func setName(name: String){
        self.name = name
    }
    func setAuthor(author: String){
        self.author = author
    }
}

class MediaItem: Media{
}

class Movie: Media{
    
}

class Music: Media{
    
}

class Book: Media{
    
}

class Library{
    var MediaItemList: [Media] = []
    var MovieList: [Movie] = []
    var MusicList: [Music] = []
    var BoolList: [Book] = []
    
    init(){
        self.MediaItemList = [Media]()
        self.MovieList = [Movie]()
        self.MusicList = [Music]()
        self.BoolList = [Book]()
    }
    
    

}
print("Please Enter your favorite programming language", terminator: ".")
let name = readLine()
print("Your favorite programming language is (name!).")
let line = readLine()


var library = Library()

