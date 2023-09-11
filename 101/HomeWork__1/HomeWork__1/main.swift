//
//  main.swift
//  HomeWork__1
//
//  Created by Нияз Ризванов on 11.09.2023.
//

import Foundation
// Ризванов Нияз 11-209
// Писал ночью не судите строго)

struct Book{
    let author:String
    let dateСreation:String
    let name:String
    let numberPages:Int
    let style:String
    let annotation:String
    let characters:String
    let readerAge:Int
    let country:String
}
struct Music{
    let name:String
    let dateСreation:String
    let author:String
    let playbackTime:String
    let text:String
    let style:String
    let listenerAge:Int
    let country:String
}
struct Movie{
    let name:String
    let dateСreatin:String
    let author:String
    let filmTime:String
    let style:String
    let description:String
    let audioTracks:String
    let caretakerAge:Int
    let country:String
    let characters:String
    let actors:String
}
class MediaItem{
    var listBooks:[Book]
    var listMovie:[Movie]
    var listMusic:[Music]
    func start(){
        if listBooks.isEmpty && listMovie.isEmpty && listMusic.isEmpty{
            selectionObjects()
            return
        }
        print("Выберите операции(добавить, удалить, поиск):")
        let operration = readLine()?.lowercased() ?? "добавить" // поумолчанию
        switch operration{
        case "добавить":
            selectionObjects()
        case "удалить":
            findsOutWhatDelete()
        case "поиск":
            findObject()
        default:
            print("Выбрана неверная операция!")
        }
    }
    func end(){
        print("Желаете продолжить?")
        if let wordContinue = readLine(){
            if wordContinue.lowercased() == "да"{
                start()
            }else {
                return
            }
        }
    }
    func selectionObjects(){ // доработать действия о некорректных данных
        print("О чём пишем ?")
        print("Выбери:(фильмы,книги,музыка)")
        if let mediaObject = readLine(){
            if  mediaObject.lowercased() == "фильмы" || mediaObject.lowercased() == "книги" || mediaObject.lowercased() == "музыка"{
                selectionScenario(object: mediaObject)
            }else{
               print("Вы ввели не коректные данные!")
            }
        }else{
            print("Вы ввели пустую строку!")
        }
    }
    func selectionScenario(object:String){
        switch object{
        case "фильмы":
            scenarioForMovie()
        case "книги":
            scenarioForBook()
        case "музыка":
            scenarioForMusic()
        default:
            print("Вы ввели не коректные данные!")
            return // выйдет если что то не то
        }
    }
    func scenarioForMovie(){
        print("Введите название фильма:")
        let name = readLine() ?? "-"
        print("Aвтор:")
        let author = readLine() ?? "-"
        print("Дата публикации:")
        let dateСreatin = readLine() ?? "-"
        print("Продолжительность фильма:")
        let filmTime = readLine() ?? "-"
        print("Жанр:")
        let style = readLine() ?? "-"
        print("Страна:")
        let country = readLine() ?? "-"
        print("Актеры:")
        let actors = readLine() ?? "-"
        print("Персонажи:")
        let characters = readLine() ?? "-"
        print("Для возраста:")
        let listenerAge = Int(readLine()!) ?? 0
        print("Аудиодорожки:")
        let audioTracks = readLine() ?? "-"
        print("Описание:")
        let description = readLine() ?? "-"
        add(object: Movie(name: name, dateСreatin: dateСreatin, author: author, filmTime: filmTime, style: style, description: description, audioTracks: audioTracks, caretakerAge: listenerAge, country: country, characters: characters, actors: actors))
        
    }
    func scenarioForMusic(){
        print("Введите название музыки:")
        let name = readLine() ?? "-"
        print("Aвтор:")
        let author = readLine() ?? "-"
        print("Дата публикации:")
        let dateСreatin = readLine() ?? "-"
        print("Продолжительность музыки:")
        let playbackTime = readLine() ?? "-"
        print("Жанр:")
        let style = readLine() ?? "-"
        print("Страна:")
        let country = readLine() ?? "-"
        print("Для возраста:")
        let listenerAge = Int(readLine()!) ?? 0
        print("Tекст песни:")
        let text = readLine() ?? "-"
        add(object:Music(name: name, dateСreation: dateСreatin, author: author, playbackTime: playbackTime, text: text, style: style, listenerAge: listenerAge, country: country))
    }
    func scenarioForBook(){
        print("Введите название книги:")
        let name = readLine() ?? "-"
        print("Aвтор:")
        let author = readLine() ?? "-"
        print("Дата публикации:")
        let dateСreatin = readLine() ?? "-"
        print("Стиль:")
        let style = readLine() ?? "-"
        print("Страна:")
        let country = readLine() ?? "-"
        print("Персонажи:")
        let characters = readLine() ?? "-"
        print("Возраст читателя:")
        let readerAge = Int(readLine()!) ?? 0
        print("Число страниц:")
        let numberPages = Int(readLine()!) ?? 0
        print("Аннотация:")
        let annotation = readLine() ?? "-"
        add(object: Book(author: author, dateСreation: dateСreatin, name: name, numberPages: numberPages, style: style, annotation: annotation, characters: characters, readerAge: readerAge, country: country))

    }
    func findsOutWhatDelete(){
        print("Что вы хотите удалить ?")
        print(" (фильм,книга,музыка)")
        let object = readLine()?.lowercased() ?? ""
        print("Название:")
        let name = readLine() ?? ""
        delete(object: object, name: name)
    }
    func findObject(){
        print("Что вы хотите найти ?")
        print(" (фильм,книга,музыка)")
        let object = readLine()?.lowercased() ?? ""
        print("Название:")
        let name = readLine() ?? ""
        search(object: object, name: name)
    }
    func add(object:Any){
        if  let newObject = object as? Movie{
            listMovie.append(newObject)
            print("Фильм успешно добавлен!")
        }else if let newObject = object as? Book{
            listBooks.append(newObject)
            print("Книга успешно добавлена!")
        }else if let newObject = object as? Music{
            listMusic.append(newObject)
            print("Музыка успешно добавлена!")
        }
        end()
    }
    func delete(object:String,name:String){
        let index = getIndexForList(object: object, name: name)
        switch object{
        case "фильм":
            if listMovie.isEmpty{
                print("Неверная операция!")
                return
            }
            listMovie.remove(at: index)
        case "книга":
            if listBooks.isEmpty{
                print("Неверная операция!")
                return
            }
            listBooks.remove(at: index)
        case "музыка":
            if listMusic.isEmpty{
                print("Неверная операция!")
                return
            }
            listMusic.remove(at: index)
        default:
            return
        }
        end()
    }
    func search(object:String,name:String){
        let index = getIndexForList(object: object, name: name)
        switch object{
        case "фильм":
            if listMovie.isEmpty{
                print("Неверная операция!")
                return
            }
            getInformationMovie(object: listMovie[index])
        case "книга":
            if listBooks.isEmpty{
                print("Неверная операция!")
                return
            }
            getInformationBooks(object: listBooks[index])
        case "музыка":
            if listMusic.isEmpty{
                print("Неверная операция!")
                return
            }
            getInformationMusic(object: listMusic[index])
        default:
            return
        }
        end()
    }
    func getIndexForList(object:String,name:String)->Int{
        switch object{
        case "фильм":
            if let index = listMovie.firstIndex(where: { (element) -> Bool in
                return element.name == name
            }) {
                return index
            } else {
                
                print("Элемент не найден")
                end()
            }
        case "книга":
            if let index = listBooks.firstIndex(where: { (element) -> Bool in
                return element.name == name
            }) {
                return index
            } else {
                print("Элемент не найден")
                end()
            }
        case "музыка":
            if let index = listMusic.firstIndex(where: { (element) -> Bool in
                return element.name == name
            }) {
                return index
            } else {
                print("Элемент не найден")
                end()
            }
        default:
            return 0
        }
        return 0
    }
    func getInformationMovie(object:Movie){
        print("Название фильма: \(object.name )")
        print("Aвтор: \(String(describing: object.author ))")
        print("Дата публикации: \(object.dateСreatin )")
        print("Продолжительность фильма: \(object.filmTime )")
        print("Жанр: \(object.style )")
        print("Страна: \(object.country )")
        print("Актеры: \(object.actors )")
        print("Персонажи: \(object.characters )")
        print("Для возраста:\(object.caretakerAge)")
        print("Аудиодорожки: \(object.audioTracks )")
        print("Описание: \(object.description )")

    }
    func getInformationBooks(object:Book){
        print("Название фильма: \(object.name )")
        print("Aвтор: \(String(describing: object.author ))")
        print("Дата публикации: \(object.dateСreation )")
        print("Жанр: \(object.style )")
        print("Страна: \(object.country )")
        print("Персонажи: \(object.characters )")
        print("Для возраста:\(object.readerAge)")
        print("Описание: \(object.annotation )")
        print("Количество страниц: \(object.numberPages)")
    }
    func getInformationMusic(object:Music){
        print("Название фильма: \(object.name )")
        print("Aвтор: \(String(describing: object.author ))")
        print("Дата публикации: \(object.dateСreation )")
        print("Жанр: \(object.style )")
        print("Страна: \(object.country )")
        print("Для возраста:\(object.listenerAge)")
        print("Текст песни: \(object.text )")
        print("Количество страниц: \(object.playbackTime )")
    }
    init(){
        self.listBooks = [Book]()
        self.listMovie = [Movie]()
        self.listMusic = [Music]()
    }
}

var mediaItems = MediaItem()
mediaItems.start()



