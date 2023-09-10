//
//  main.swift
//  MarwaHomeWork1
//
//  Created by marwa awwad mohamed awwad on 10.09.2023.
//

import Foundation


// Protocol for multimedia items
protocol MultimediaItem {
    
    var title: String { get set}
    
    var creatorOfTheProject: String { get set}
    
    var time: Int { get set}
    
    func displayInfo()
    
}


// Class for representing a movie
class Movie {
    let title : String
    let rate: Double
    let Director: String
    let time: Int

    
    
    init(title: String,rate: Double,Director: String ,time : Int, top10: Bool, actors: [String]) {
        self.title = title
        self.rate = rate
        self.Director = Director
        self.time = time

      
        
    }
    func displayInfo() {
        print("Title: \(title)")
        print("Director: \(Director)")
        print("Time: \(time) minutes")
    }
    
  
}

func runMovies() {
    let movie1 = Movie(title: "Movie 1", rate: 7.5, Director: "Director 1", time: 120,top10: true, actors: ["actor1","actor2", "actor3"])
                                                                                                    
    let movie2 = Movie(title: "Movie 2", rate: 8.0, Director: "Director 2", time: 150,top10: false,actors: ["actor1","actor2", "actor3"])
    
    
    print(movie1.displayInfo())
    print("-------------------------------------------------------------------------------")
    print(movie2.displayInfo())
    print("-------------------------------------------------------------------------------")


}

// Run the movies
runMovies()

    


// Struct for representing a book
struct Book: MultimediaItem {
    
    var time: Int
    var numberOfPages: Int
    var title: String
    var creatorOfTheProject: String
      var coppies: Int
    
    
    init(title: String, creatorOfTheProject: String, numberOfPages: Int, time: Int, copies: Int){
        self.title = title
        self.creatorOfTheProject = creatorOfTheProject
        self.numberOfPages = numberOfPages
        self.time = time
        self.coppies = copies
        
    }
    
    func displayInfo() {
        
        print("Title: \(title)")
        print("Writer: \(creatorOfTheProject)")
        print("numberOfPages :\(numberOfPages)")
        print("number of copies :\(coppies)")
        
    }
}


    func showBooks() {
        
        let book1 = Book(title: "Brothers Karamazov", creatorOfTheProject: "Fyodor Dostoevsky. ", numberOfPages: 200, time: 0, copies: 10000)
        print(book1.displayInfo())
        print("-------------------------------------------------------------------------------")

        let book2 = Book(title: "Dead Souls", creatorOfTheProject: "Nikolai Gogo", numberOfPages: 300, time: 0, copies: 130000)
        print(book2.displayInfo())
        print("-------------------------------------------------------------------------------")

    }
    
    
    showBooks()

    

// Struct for representing a book
struct Song: MultimediaItem {
    var creatorOfTheProject: String
    

    var title: String
    var time: Int
    var numberOfVerses: Int
    var singer: String
    var singers: [String]
    
    init(title: String, time: Int, numberOfVerses: Int, singer: String, singers: [String],creatorOfTheProject: String) {
        self.creatorOfTheProject = creatorOfTheProject // You can set it to nil to indicate it's optional.
        self.title = title
        self.time = time
        self.numberOfVerses = numberOfVerses
        self.singer = singer
        self.singers = singers
    }
    
    func displayInfo() {
        print("Title: \(title)")
        print("Singer: \(singer)")
        print("Time: \(time)")
        print("Number of Verses: \(numberOfVerses)")
        print("The Singers: \(singers.joined(separator: ", "))")
    }
}

        
        
        

    func showSong() {
        
        
      

        
        let song2 = Song( title: "Дом убит", time: 289, numberOfVerses: 4, singer: "any singer",singers: ["Gizmo" , "Мимо", "Ранен", "Убит"], creatorOfTheProject: "")
        print(song2.displayInfo())
        print("-------------------------------------------------------------------------------")
        
        //        singers.append("new singer")
        let song2_Cover = Song( title: "Дом убит", time: 289, numberOfVerses: 4, singer: "any singer",singers: ["Gizmo" , "Мимо", "Ранен", "Убит"], creatorOfTheProject: "")
        print(song2.displayInfo())
        print("-------------------------------------------------------------------------------")
    }
    

    showSong()

    
