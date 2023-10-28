import Foundation

//Доп Задания
//1
func firstEvenNumber(numbers: [Int]) -> Int? {
    return numbers.first { $0 % 2 == 0 }
}

//2
func firstStringStartsWithLetter (strings: [String], letter: Character) -> String? {
    return strings.first { $0.first == letter }
}
