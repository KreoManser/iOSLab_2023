import Foundation

//Доп Задания
//1
func longWordsFilter(words: [String]) -> [String] {
    let filteredWords = words.filter { word in
        return word.count > 5
    }
    return filteredWords
}

let words = ["aaaa", "bb", "nnnnmm", ""]
print(longWordsFilter(words: words))

//2
func EvenNumbersFilter(numbers: [Int]) -> [Int] {
    return numbers.filter { $0 % 2 == 0 }
}

let numbers = [1,2,4,5,9,8,6,11]
print(EvenNumbersFilter(numbers: numbers))
