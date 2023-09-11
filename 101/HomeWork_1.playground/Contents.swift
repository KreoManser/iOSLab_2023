import UIKit
// Ризванов Нияз 11-209

// 1
let noFillterWords = ["apple", "banana", "cherry", "grape", "orange"]
func filterWordsCountMoreFive(words:[String]) -> [String] {
    let fillterWords = words.filter { item in
        item.count > 5
        
    }
    return fillterWords
}
print(filterWordsCountMoreFive(words: noFillterWords))

// 2
let noFillterNumbers = [21,4,6,9,50,10,5,7,2,3]
func fillterEvenNumbers(number:[Int]) -> [Int] {
    let fillterNumbers = number.filter { item in
        item % 2 == 0
    }
    return fillterNumbers
}
print(fillterEvenNumbers(number: noFillterNumbers))
