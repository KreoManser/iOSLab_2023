import Foundation
let listWords = ["Hasbulla", "computer", "elephant", "cat", "Kazan", "basilic"]
let listNumbers = [5,3,4,25,1,53,66,33,22,10,100,3,5,2]


func filterFunctions(){
    let wordsResult = filterWords(words: listWords)
    let numbersResult = filterNumbers(numbers: listNumbers)
    print("words: \(wordsResult) \n")
    print("numbers: \(numbersResult) \n")
}

func filterWords(words: Array<String>) -> Array<String>{
    let result = words.filter { $0.count > 5 }
    return result
}

func filterNumbers(numbers:Array<Int>) -> Array<Int> {
    let result = numbers.filter { $0 % 2 == 0 }
    return result
}
