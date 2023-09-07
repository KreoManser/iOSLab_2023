//
//  main.swift
//  Hw1
//
//  Created by surexnx on 05.09.2023.
//

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
    init(name:String, author:String,grade:Int){
        self.name = name
        self.author = author
        self.grade = grade
    }
    
    
    func getName() -> String{
        return name
    }
    
    func getAuthor() -> String{
        return author
    }
    
    func getGrade() -> Int{
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
    
    func printMedia(){
        print("name: " + name + " author :" + author + " grade: " + String(grade))
    }
}



class MediaArray{
    var MediaItemList:[Media]
    
    init(){
        self.MediaItemList = []
        
    }
    
    func printMediaItemList(){
        var i = 1
        for media in MediaItemList{
            print(String(i) + ". name: " + media.name + " author: " + media.author)
            i+=1
            
        }
    }
    
    func search(str:String){
        for media in MediaItemList{
            if(media.getName() == str || media.getAuthor() == str){
                media.printMedia()
            }
        }
    }
    
    func delete(str:String){
        if(MediaItemList.isEmpty){
            var j = 0
            for i in MediaItemList.enumerated(){
                j = i.offset
            }
            MediaItemList.remove(at: j)
        }
        }
    
    func deleteByNumber(num:Int){
        for i in MediaItemList.enumerated(){
            if num+1 == i.offset{
                MediaItemList.remove(at: i.offset)
            }
        }
    }
    
    func incertMedia(media:Media){
        MediaItemList.append(media)
}
    
    func setGrade(num:Int,grade:Int){
        MediaItemList[num].grade = grade
    }
    
    func learnTop(){
        MediaItemList = MediaItemList.sorted(by: { $0.grade < $1.grade })
        for i in MediaItemList{
            i.printMedia()
        }
    }
    
    func topTрree(){
        if MediaItemList.capacity > 2{
            for i in 0 ... 2{
                MediaItemList[i].printMedia()
            }
        
        }
    }
}
    
class Library{
    var MediaItemArray:MediaArray
    var MovieArray:MediaArray
    var MusicArray:MediaArray
    var BookArray:MediaArray
    
    init() {
        self.MediaItemArray = MediaArray()
        self.MovieArray = MediaArray()
        self.MusicArray = MediaArray()
        self.BookArray = MediaArray()
    }
    func search(num:Int, str:String){
        switch num{
        case 1:
            MediaItemArray.search(str: str)
            break
        case 2:
            MediaItemArray.search(str: str)
            break
        case 3:
            MusicArray.search(str: str)
            break
        case 4:
            BookArray.search(str: str)
            break
        default:
            print("error")
            
        }
    }
    
    func delete(num:Int, numDel:Int){
        switch num {
        case 1:
            MediaItemArray.deleteByNumber(num: numDel)
            break
        case 2:
            MovieArray.deleteByNumber(num: numDel)
            break
        case 3:
            MusicArray.deleteByNumber(num: numDel)
            break
        case 4:
            BookArray.deleteByNumber(num: numDel)
            break
            
        default:
            print("error")
        }
    }
    
    func getSize(num: Int) -> Int{
        switch num {
        case 1:
            return MediaItemArray.MediaItemList.capacity
        case 2:
            return MovieArray.MediaItemList.capacity
        case 3:
            return MusicArray.MediaItemList.capacity
        case 4:
            return BookArray.MediaItemList.capacity
            
        default:
            print("error")
            return 0
        }
    }
    
    func libraryIncert(num: Int, media: Media){
        switch num{
            case 1:
            MediaItemArray.incertMedia(media: media)
            break
        case 2:
            MovieArray.incertMedia(media: media)
            
            break
        case 3:
            MusicArray.incertMedia(media: media)
            break
            case 4:
            BookArray.incertMedia(media: media)
            break
            default:
                print("Попробуй ввести верно")
            break
                }
    }
    
    func librarySelect(num:Int){
                switch num{
                    case 1:
                    MediaItemArray.printMediaItemList()
                    break
                case 2:
                    MovieArray.printMediaItemList()
                    
                    break
                case 3:
                    MusicArray.printMediaItemList()
                    break
                    case 4:
                    BookArray.printMediaItemList()
                    break
                    default:
                        print("Попробуй ввести верно")
                    break
                        }
    }
    
    func setGrade(num:Int, grade:Int){
        switch num{
            case 1:
            MediaItemArray.setGrade(num: num, grade: grade)
            break
        case 2:
            MovieArray.setGrade(num: num, grade: grade)
            
            break
        case 3:
            MusicArray.setGrade(num: num, grade: grade)
            break
            case 4:
            BookArray.setGrade(num: num, grade: grade)
            break
            default:
                print("error")
            break
                }
    }
    
    func printTop(num:Int){
        switch num{
            case 1:
            MediaItemArray.learnTop()
            break
        case 2:
            MovieArray.learnTop()
            
            break
        case 3:
            MusicArray.learnTop()
            break
            case 4:
            BookArray.learnTop()
            break
            default:
                print("error")
            break
                }
    }
    
    
    
    
}


var diction: [String] = ["0? 1.Посмотреть список музыкальных элементов \n 2.Посмотреть список фильмов \n 3.Посмотреть список музыки \n 4.Посмотреть список книг                        \n 5.Выход",
                         "1? 1.Выбрать 2.Поиск 3.Удалить 4.Добавить 5.Рейтинг 6.Назад 0.Выход",
                         "2? 1.Поставить оценку 2.Назад 0.Выход",
                         "3? Введите что хотите найти",
                         "4? Выберите цифру удаления 0.назад",
                         "5? Введите название 0.назад",
                         "6? Введите автора 0.назад",
                         "7 какую оценку хотите поставить",
                         "8 ",
                         "9 ",
                         "10 "
                         
                         
]

print("Вас приветсвует медиа библиотека")
print("Пока что имеется список фильмов")


var line = ""
var library = Library()

library.MediaItemArray.incertMedia(media: Media(name: "aa", author: "cd", grade: 9))
library.MediaItemArray.incertMedia(media: Media(name: "name", author: "author", grade:9))
library.MediaItemArray.incertMedia(media: Media(name: "name2", author: "author", grade: 8))
library.MediaItemArray.incertMedia(media: Media(name: "name3", author: "author", grade: 4))
library.MediaItemArray.incertMedia(media: Media(name: "name4", author: "author", grade: 3))

var check = false
var array: [Media]
var typeMedia = 0
var next = 0
var name = ""
var author = ""
var number: Int = 0

while(check != true){
    print(diction[next])
    
    line = readLine()!
    switch Int(next){
    case 0:
        switch Int(line){ //.Посмотреть список музыкальных элементов \n 2.Посмотреть список фильмов \n 3.Посмотреть список музыки \n 4.Посмотреть список книг                        \n 5.Выход
        case 1:
            library.MediaItemArray.printMediaItemList()
            typeMedia = 1
            next = 1
            continue
        case 2:
            library.MovieArray.printMediaItemList()
            typeMedia = 2
            next = 1
            continue
        case 3:
            library.MusicArray.printMediaItemList()
            typeMedia = 3
            next = 1
            continue
        case 4:
            library.BookArray.printMediaItemList()
            typeMedia = 4
            next = 1
            continue
        case 0:
            check = true
            continue
        default:
            print("Попробуй ввести верно")
            continue
        }
    case 1:
        switch Int(line){ // .Выбрать 2.Поиск 3.Удалить 4.Добавить 5.Рейтинг 0.Выход
        case 1:
            next = 2
            continue
        case 2:
            next = 3
            continue
        case 3:
            next = 4
            continue
        case 4:
            next = 5
            continue
        case 5:
            next = 8
            continue
        case 6:
            next = 0
            continue
        case 0:
            check = true
            continue
        default:
            print("Попробуй ввести верно")
            continue
        }
    case 2:
        
        if Int(line) != 0{
            if Int(line)! < library.getSize(num: typeMedia) {
                number = Int(line)!
                next = 7
                continue
            }else{
                print("error")
                next = 2
            }
        }else{
            next = 1
            continue
        }
    case 4:
        library.librarySelect(num: typeMedia) //Выберите цифру удаления 0.назад"
        if Int(line) != 0{
            if Int(line)! < library.getSize(num: typeMedia) {
                library.delete(num: typeMedia, numDel: Int(line)!)
                continue
            }else{
                next = 4
                print("error")
            }
        }else{
            next = 1
            continue
        }
        
    case 3:
        if(Int(line) == 0){
            next = 1
            continue
        }else{
            library.search(num: typeMedia, str: line)
            continue
        }
    case 5:
        if(line == "0"){
            next = 1
            continue
        }else{
            name = line
        next = 6
        }
    case 6:
        if(line == "0"){//Введите автора 0.назад"
            next = 5
            continue
        }else{
            author = line
            library.libraryIncert(num: typeMedia, media: Media(name: name, author: author))
        next = 1
        }
        case 7:
        if(Int(line) == 0){
            next = 1
            continue
        }else{
            let numberLine = Int(line)
            library.setGrade(num: number, grade: numberLine!)
            next = 1
            continue
        }
            case 8:
        if(line == "0"){
            next = 1
            continue
        }else{
            library.printTop(num: typeMedia)
        }
                
         
    default:

        print("error")
    }
    
}
