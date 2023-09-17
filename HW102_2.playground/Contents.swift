import UIKit

func findFirstEvenNumber(numbers: [Int]) -> Int? {
    return numbers.first { $0 % 2 == 0 }
}

func findFirstStringStartingWith(letter: Character, _ strings: [String]) -> String? {
    return strings.first(where: { $0.first == letter })
}
