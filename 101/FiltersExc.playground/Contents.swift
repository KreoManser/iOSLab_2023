import UIKit

func getWordsWithFivePlusLetters(words:[String]) -> [String]{
    return words.filter{ ourWord in ourWord.count > 5 }
}

func getOnlyEvenNumbers(numbers: [Int]) -> [Int]{
    return numbers.filter{ num in num % 2 == 0 }
}

let words = ["yadebil", "xdxd", "AыыыыыЫЫЫЫ", ""]
getWordsWithFivePlusLetters(words: words)
let numbers = [1,2,3,4,4,4,4,4,4,4,0,-2]
getOnlyEvenNumbers(numbers: numbers)
