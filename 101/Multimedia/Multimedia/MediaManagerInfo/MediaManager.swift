//
//  MediaManager.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

class MediaManager: MediaManagerProtocol{
    var listOfMedia: [TypeOfMedia : [MediaItem]] = [TypeOfMedia.book: [], TypeOfMedia.movie: [], TypeOfMedia.music: []]
    
    func findItemByName(name: String) -> [MediaItem]{
        findSomething(criteria: name)
    }
    
    func findItemByAuthor(author: String) -> [MediaItem] {
        findSomething(criteria: author)
    }
    
    func findItemByMediaType(type: TypeOfMedia) -> [MediaItem] {
        findSomething(criteria: type.rawValue)
    }
    
    func addItem(item: MediaItem) {
        let type = item.typeOfmedia
        listOfMedia[type]?.append(item)
        print("Элемент \(item.name) успешно добавлен")
    }
    
    func deleteItem(item: MediaItem) {
        let type = item.typeOfmedia
        
        if let index = listOfMedia[type]?.firstIndex(of: item) {
            listOfMedia[type]?.remove(at: index)
        }
        
        print("Элемент \(item.name) успешно удалён")
    }
    
    /// функция поиска по какому-то критерию
    private func findSomething (criteria: String) -> [MediaItem]{
        var foundItems: [MediaItem] = []
        
        for (type, mediaItems) in listOfMedia {
            if type.rawValue == criteria {
                for item in mediaItems{
                    foundItems.append(item)
                }
                break
            }
            for item in mediaItems {
                if item.name == criteria || item.author == criteria {
                    foundItems.append(item)
                }
            }
        }

        if foundItems.isEmpty {
            print("К сожалению, по вашему запросу ничего не найдено")
            return []
        }
        else {
            for findedItem in foundItems {
                printItem(item: findedItem)
            }
            return foundItems
        }
    }
    
    /// выводит элемент в зависимости от его типа
    private func printItem (item: MediaItem) {
        if let book = item as? Book {
            print("Название: \(book.name), Тип: \(book.typeOfmedia), Автор: \(book.author), Рейтинг: \(book.rating), Жанр/Жанры: \(book.genre), Количество страниц: \(book.amountOfPages) \n ")
        }
        else if let movie = item as? Movie {
            print("Название: \(movie.name), Тип: \(movie.typeOfmedia), Автор: \(movie.author), Рейтинг: \(movie.rating), Жанр/Жанры: \(movie.genre), Длительность фильма: \(movie.duration) \n ")
        }
        else if let music = item as? Music {
            print("Название: \(music.name), Тип: \(music.typeOfmedia), Автор: \(music.author), Рейтинг: \(music.rating), Жанр/Жанры: \(music.genre), Альбом: \(music.album) \n ")
        }
        else {
            print("Что-то пошло не так при выводе элементов")
        }
    }
}

extension MediaManager: MediaRatingProtocol {
    
    /// метод добавления рейтинга
    func estimateItem(item: MediaItem, rating: Double) {
        item.rating = (item.rating + rating) / Double((item.amountOfRatings + 1))
        print("Ваш рейтинг был учтён, текущий рейтинг: \(item.rating)")
    }
    
    /// считает рейтинг по всем медиа или конкретному типу
    func givePopularItems(type: TypeOfMedia?) {
        let rating = countMiddleRating()
        var popularItems: [MediaItem] = []
        
        if type == nil{
            for listWithMedia in listOfMedia.values {
                for item in listWithMedia {
                    if item.rating > rating {
                        popularItems.append(item)
                    }
                }
            }
        }
        for item in listOfMedia[type!] ?? []{
            if item.rating > rating {
                popularItems.append(item)
            }
        }
        
        if popularItems.isEmpty {
            print("К сожалению, по вашему запросу нет элементов и рейтинга")
        }
        for item in popularItems {
            printItem(item: item)
        }
    }
    
    /// считает средний рейтинг
    private func countMiddleRating() -> Double {
        var ratings: [Double] = []
        var sumOfRatings: Double = 0
        
        for listWithMedia in listOfMedia.values {
            for item in listWithMedia {
                ratings.append(item.rating)
            }
        }
        
        for mark in ratings {
            sumOfRatings += mark
        }
        
        if ratings.isEmpty || sumOfRatings == 0{
            print("К сожалению, сейчас нет оценок, нельзя посчитать рейтинг")
            return 0
        }
        
        return sumOfRatings / Double(ratings.count)
    }
}
