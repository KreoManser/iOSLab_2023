//
//  MediaManagerInterface.swift
//  HW1
//
//  Created by Kseniya Skvortsova on 13.09.2023.
//

import Foundation

@main
struct MediaManagerInterface {
    
    static let itemManager=MediaManager()
    
    static func main() {
        menu()
    }
    
    static func menu(){
        
        var running=true
        while running{
            print("Choose option")
            print("1.Add a new media")
            print("2.Remove a media")
            print("3.Find a media")
            
            let num=readLine()
            
            switch num {
            case "1":
                add()
            case "2":
                remove()
            case "3":
                find()
            default:
                print("You must enter only 1,2,3")
            }
        }
    }
    
    static func find(){
        print("Choose a media to find")
        print("1.Book")
        print("2.Music")
        print("3.Movie")
        print("4.back")
        
        let num=readLine()
        
        switch num {
        case "1":
            itemManager.find(param: 0)
        case "2":
            itemManager.find(param: 1)
        case "3":
            itemManager.find(param: 2)
        case "4":
            menu()
        default:
            print("You must enter only 1,2,3,4")
            add()
        }
    }
    
    static func remove(){
        print("Choose a media to remove")
        print("1.Book")
        print("2.Music")
        print("3.Movie")
        print("4.back")
        
        let num=readLine()
        var mi :MediaItem
        
        switch num {
        case "1":
            mi=Book()
            itemManager.remove(item: mi)
        case "2":
            mi=Music()
            itemManager.remove(item: mi)
        case "3":
            mi=Movie()
            itemManager.remove(item: mi)
        case "4":
            menu()
        default:
            print("You must enter only 1,2,3,4")
            remove()
        }
    }
    
    static func add() {
        print("Choose a media to add")
        print("1.Book")
        print("2.Music")
        print("3.Movie")
        print("4.back")
        
        let num=readLine()
        var mi :MediaItem
        
        switch num {
        case "1":
            mi=Book()
            itemManager.add(item: mi)
        case "2":
            mi=Music()
            itemManager.add(item: mi)
        case "3":
            mi=Movie()
            itemManager.add(item: mi)
        case "4":
            menu()
        default:
            print("You must enter only 1,2,3,4")
            add()
        }
    }
}
