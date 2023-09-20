import UIKit

func firstEvenNumber(array: [Int]) -> Int? {
    if let item = array.first(where: {$0 % 2 == 0}) {
        return item
    }
    return nil
}

firstEvenNumber(array: [ 1, 3, 4, 5, 6 ])



func findWordsC( words: [String]) -> String? {
    let filteredWords = words.first { word in
        if let firstCharacter = word.first, firstCharacter == "c" {
            return true
        }
        return false
    }
    return filteredWords
}

findWordsC(words: [ "gdfjjdfg", "cdfjjdfg", "gdfjjdfg", "gdfjjdfg" ])
