//
//  main.swift
//  HW1
//
//  Created by Dmitry on 13.09.2023.
//

import Foundation

let mediaItemMananger = MediaItemManager()

// Недоделал пользовательский интерфейс

//printInfo()
//func printInfo() {
//    print("Добро пожаловать в библитеку мультимедиа!\n Пул команд:\n1.Добавить медиа-объект в библиотеку\n2.Удалить медиа-объект\n3.Найти медиа-объект по имени\n4.Найти медиа-объект по автору\n5.Показать список команд")
//}

//while true {
//    var input: String = readLine() ?? ""
//    switch input {
//    case "Добавить медиа-объект в библиотеку":
//        print("Введите тип медиа , имя произведения, имя автора и рейтинг через запятую.\n Пример: книга,Буратино,Алексей Толстой,5")
//        let newMediaObject = readLine()?.split(separator: ",")
//        if newMediaObject?[0] == "книга" {
//            let name = newMediaObject?[1]
//            let book = Book(name: String(newMediaObject?[1] ?? ""), author: String(newMediaObject?[2] ?? ""), rating: Double(from: newMediaObject?[3] ?? 0))
//            mediaItemMananger.addMedia(media: book)
//    case "Удалить медиа-объект":
//        print("Введите номер элемента: ")
//        if let index = readLine() {
//            mediaItemMananger.deleteMedia(index: Int(index) ?? -1)
//        }
//    default:
//        print("Данной команды нет в списке команд")
//    }
//}

protocol MediaItem {
    var name: String { get set }
    var author: String { get set }
    var rating: Double { get }
}
struct Movie: MediaItem {
    var name: String
    var author: String
    var rating: Double
    
}
struct Music: MediaItem {
    var name: String
    var author: String
    var rating: Double
    
}
struct Book: MediaItem {
    var name: String
    var author: String
    var rating: Double
}

class MediaItemManager {
    var listOfMedia = [MediaItem]()
    
    func addMedia(media: MediaItem) {
        listOfMedia.append(media)
    }
    
    func deleteMedia(index: Int) {
        listOfMedia.remove(at: index)
    }
    
    func findMediaByAuthor(author: String) -> MediaItem? {
        listOfMedia.first(where: { $0.author == author })
    }
    
    func findMediaByName(name: String) -> MediaItem? {
        listOfMedia.first(where: { $0.name == name })
    }
}

// Дополнительные задания

func sortWordsArray(array: [String]) -> [String] {
    array.filter({ $0.count > 5 })
}

func sortNumbersArray(array: [Int]) -> [Int] {
    array.filter( {$0 % 2 != 0 })
}




