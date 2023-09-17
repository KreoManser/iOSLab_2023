import UIKit

// 1
func getFirstEvenNumber(numbers: [Int]) -> Int?{
    var evenNumber: Int? = numbers.first{
        number in return number % 2 == 0
    }
    return evenNumber
}
// 2
func firstStringWithUniqueLetter(strings: [String], letter: Character) -> String? {
    let uniqueString: String? = strings.first {
        string in return string.first == letter
    }
    return uniqueString
}
// Вызов функций
let letter: Character = "s"
let numbers: [Int] = [1, 17, 19, 15, 256, 13, 33, 44, 89, 124]
let strings: [String] = ["apple", "mouse", "car", "swift", "laptop", "pencil", "summer"]
if let evenNumber = getFirstEvenNumber(numbers: numbers) {
    print("Первое четное число: \(evenNumber)")
} else {
    print("Четное число отсутствует")
}
if let firstMatch = firstStringWithUniqueLetter(strings: strings, letter: letter) {
    print("Первое слово начинающее на букву \(letter): \(firstMatch)")
} else {
    print("Слова на букву \(letter) отсутсвует")
}



