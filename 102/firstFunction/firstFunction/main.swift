import Foundation

print("Первое задание")
let numbers = [1, 7, 5, 9, 6, 7, 8]
print(numbers)
func findEvenFirst(numbers: [Int]) -> Int? {
    return numbers.first(where: { $0 % 2 == 0 })
}

if let firstEven = findEvenFirst(numbers: numbers) {
    print(firstEven)
}

print("Второе задание")
let strings = ["aaaa", "bbbbb", "ccccc", "ddddd","eee"]
print(strings)
func findFirstWord(strings: [String], letter: Character) -> String? {
    return strings.first(where: { $0.hasPrefix(String(letter)) })
}

if let wordWithD = findFirstWord(strings: strings, letter: "d") {
    print(wordWithD)
}


