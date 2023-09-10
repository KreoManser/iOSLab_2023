//
//  main.swift
//  Multimedia
//
//  Created by Mac on 2023-09-09.
//

import Foundation

let mediaManager = MediaManager()
firstTime()

private func firstTime () {
    print("Главное меню \nЧто вы хотите сделать? Введите нужную цифру \n1) Найти какой-то объект в библиотеке \n2) Добавить какой-то объект в библиотеку \n3) Удалить какой-то объект из библиотеки \n4) Оценить какой-то объект \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
    choiceFromMainMenu()
}

/// считывает действия из главного меню
private func choiceFromMainMenu () {
    let mainMenuChoice = readInt()
    
    switch mainMenuChoice {
    case 1:
        print("\nМеню поиска объектов \nЧто вы хотите найти? Выберите нужную цифру \n1) Песни \n2) Фильмы \n3) Книги \n4) Хочу найти по автору \n5) Хочу найти по названию \n6) Вернуться в главное меню \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
        choiceFromFindItem()
    case 2:
        print("\nМеню добавления объектов \nЧто вы хотите добавить? Выберите нужную цифру \n1) Песню \n2) Фильм \n3) Книжку \n4) Вернуться в главное меню \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
        choiceFromAddItem()
    case 3:
        print("\nМеню удаления объектов \nЧто вы хотите удалить? Выберите нужную цифру \n1) Песню \n2) Фильм \n3) Книжку \n4) Вернуться в главное меню \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
        choiceFromDeleteItem()
    case 4:
        print("\nМеню оценивания объектов \nЧто вы хотите оценить? Выберите нужную цифру \n1) Песню \n2) Фильм \n3) Книжку \n4) Вернуться в главное меню \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
        choiceFromEstimateItem()
    default:
        print("\nК сожалению, вы ввели что-то неверно, повторите попытку")
        choiceFromMainMenu()
    }
}

/// считывает действия из меню выбора объектов
private func choiceFromFindItem () {
    let findItemChoice = readInt()
    let typeOfMedia = TypeOfMedia.self
    
    switch findItemChoice {
    case 1:
        print("\nВот весь список песен из библиотеки:")
        let result = mediaManager.findItemByMediaType(type: typeOfMedia.music)
        wantToPreviousMenu(numberOfPrevious: 1)
    case 2:
        print("\nВот весь список фильмов из библиотеки:")
        let result = mediaManager.findItemByMediaType(type: typeOfMedia.movie)
        wantToPreviousMenu(numberOfPrevious: 1)
    case 3:
        print("\nВот весь список книг из библиотеки:")
        let result = mediaManager.findItemByMediaType(type: typeOfMedia.book)
        wantToPreviousMenu(numberOfPrevious: 1)
    case 4:
        print("\nВведите автора:")
        let author = readString()
        print("\nВот весь список работ этого автора из библиотеки:")
        let result = mediaManager.findItemByAuthor(author: author)
        wantToPreviousMenu(numberOfPrevious: 1)
    case 5:
        print("\nВведите название:")
        let name = readString()
        print("\nВот весь список работ по этому названию из библиотеки: \n")
        let result = mediaManager.findItemByName(name: name)
        wantToPreviousMenu(numberOfPrevious: 1)

    case 6:
        firstTime()
    default:
        print("\nК сожалению, вы ввели что-то неверно, повторите попытку")
        choiceFromFindItem()
    }
}

/// считывает действия из меню добавления объектов
private func choiceFromAddItem () {
    let addItemChoice = readInt()
    let typeOfMedia = TypeOfMedia.self
    
    switch addItemChoice {
    case 1:
        let item = createItem(typeOfItem: typeOfMedia.music)
        print("Введите альбом песни:")
        let album = readString()
        let music = Music(item: item, album: album)
        mediaManager.addItem(item: music)
        wantToPreviousMenu(numberOfPrevious: 2)
    case 2:
        let item = createItem(typeOfItem: typeOfMedia.movie)
        print("Введите длительность фильма:")
        let duration = readDouble()
        let movie = Movie(item: item, duration: duration)
        mediaManager.addItem(item: movie)
        wantToPreviousMenu(numberOfPrevious: 2)
    case 3:
        let item = createItem(typeOfItem: typeOfMedia.book)
        print("Введите количество страниц в книге:")
        let amountOfPages = readInt()
        let book = Book(item: item, amountOfPages: amountOfPages)
        mediaManager.addItem(item: book)
        wantToPreviousMenu(numberOfPrevious: 2)
    case 4:
        firstTime()
    default:
        print("\nК сожалению, вы ввели что-то неверно, повторите попытку")
        choiceFromAddItem()
    }
}

/// считывает действия из меню удаления объектов
private func choiceFromDeleteItem () {
    let deleteItemChoice = readInt()
    let typeOfMedia = TypeOfMedia.self
    
    switch deleteItemChoice {
    case 1, 2, 3:
        deleteItem()
    case 4:
        firstTime()
    default:
        print("\nК сожалению, вы ввели что-то неверно, повторите попытку")
        choiceFromDeleteItem()
    }
}

/// считывает действия из меню оценивания объектов
private func choiceFromEstimateItem () {
    let estimateItemChoice = readInt()
    let typeOfMedia = TypeOfMedia.self
    
    switch estimateItemChoice {
    case 1, 2, 3:
        estimateItem()
        wantToPreviousMenu(numberOfPrevious: 2)
    case 4:
        firstTime()
    default:
        print("\nК сожалению, вы ввели что-то неверно, повторите попытку")
        choiceFromAddItem()
    }
}

/// вспомогательная функция, оценивает элемент
private func estimateItem () {
    let items = findElement()
    if items.count == 1 {
        print("Этот элемент хотите оценить? Если да, то напишите оценку от 1 до 10")
        let mark = readDouble()
        mediaManager.estimateItem(item: items[0], rating: mark)
    }
    else if items.count > 1{
        print("Выберите элемент из списка и напишите номер")
        let number = readInt()
        print("Этот элемент хотите оценить? Если да, то напишите оценку от 1 до 10")
        let mark = readDouble()
        mediaManager.estimateItem(item: items[0], rating: mark)
    }
    else {
        print("Что-то пошло не так")
    }
}

/// вспомогательная функция, возвращает в предыдущий пункт меню
private func wantToPreviousMenu (numberOfPrevious: Int) {
    print("\nЕсли хотите вернуться в предыдущее меню, то введите '\(numberOfPrevious)' \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
    choiceFromMainMenu()
}

/// вспомогательная функция, удаляет конкретный элемент
private func deleteItem () {
    let items = findElement()
    print("Удаляем его? \nДа \nНет")
    let answer = readString()
    switch answer {
    case "Да":
        for item in items {
            mediaManager.deleteItem(item: item)
        }
        print("\nЕсли хотите вернуться в предыдущее меню, то введите '3' \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
        choiceFromMainMenu()
    case "Нет":
        print("\nЕсли хотите вернуться в предыдущее меню, то введите '3' \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
        choiceFromMainMenu()
    default:
        print("\nЧто-то пошло не так, если хотите вернуться в предыдущее меню, то введите '3' \n(Цифру нужно вводить без каких-либо знаков, после ввода цифры необходимо нажать 'enter')")
        choiceFromMainMenu()
    }
}

/// вспомогательная функция, ищет элемент по автору или названию
private func findElement () -> [MediaItem] {
    print("Введите название или автора")
    let criteria = readString()
    let items = mediaManager.findItemByAuthor(author: criteria)
    return items
}

/// вспомогательная функция, создаёт конкретный элемент
private func createItem (typeOfItem: TypeOfMedia) -> MediaItem {
    print("Введите имя элемента:")
    let name = readString()
    
    print("Введите автора:")
    let author = readString()
    
    print("Введите, какое количество оценило элемент, если оценок нет, введите 0")
    let amountOfRatings = readInt()
    
    var rating: Double = 0
    if amountOfRatings != 0 {
        print("Введите рейтинг элемента от 1 до 10, если его нет, введите 0:")
        rating = readDouble()
    }
    
    let genre = addGenre(array: [])
    
    return MediaItem(name: name, author: author, rating: rating, genre: genre, typeOfmedia: typeOfItem, amountOfRatings: amountOfRatings)
}

/// вспомогательная функция, добавляет 1 или несколько жанров
private func addGenre (array: [String]) -> [String] {
    print("Введите жанр:")
    var genres = array
    genres.append(readString())
    
    print("Хотите добавить жанры? \n1) Да \n2) Нет")
    switch readInt() {
    case 1:
        genres = addGenre(array: genres)
    case 2:
        return genres
    default:
        print("Вы ввели что-то не то, попробуйте ещё раз")
        genres = addGenre(array: genres)
    }
    return genres
}

/// вспомогательная функция, считывает строку с консоли, пытается преобразовать в число
private func readInt () -> Int {
    if let choice = readLine(), let intChoice = Int(choice), !choice.isEmpty {
        return intChoice
    }
    else {
        print("\nВы ввели не число или ничего не ввели")
        return 0
    }
}

/// вспомогательная функция, считывает строку с консоли, пытается преобразовать в число
private func readDouble () -> Double {
    if let choice = readLine(), let doubleChoice = Double(choice), !choice.isEmpty {
        return doubleChoice
    }
    else {
        print("\nВы ввели не число или ничего не ввели")
        return 0
    }
}

/// вспомогательная функция, считывает строку с консоли, убирает optional
private func readString () -> String {
    if let choice = readLine(), !choice.isEmpty {
        return choice
    }
    else {
        print("\nВы ввели не строку или ничего не ввели")
        return ""
    }
}

