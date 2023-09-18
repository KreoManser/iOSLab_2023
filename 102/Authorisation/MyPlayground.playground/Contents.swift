import UIKit

func findNumbers (numbers: [Int]) -> Int? {
    return numbers.first{ $0 % 2 == 0 }
}

func firstLetter (words: [String], letter: Character) -> String? {
    return words.first{ $0.first == letter }
}

findNumbers(numbers: [0, 4, 8, 0, 9])
firstLetter(words: ["dfg gfhj 7", "dfghyjk", "7643"], letter: "d")

