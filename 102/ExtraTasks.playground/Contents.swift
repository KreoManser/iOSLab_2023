import UIKit

// FIRST TASK
let numbers = [1, 3, 5, 6, 7, 8, 9, 10]


if let firstEven = findFirstEvenNumber(in: numbers) {
    print("Первое четное число в массиве: \(firstEven)")
} else {
    print("Четных чисел в массиве нет.")
}

func findFirstEvenNumber(in numbers: [Int]) -> Int? {
    return numbers.first(where: { $0 % 2 == 0 })
}



//SECOND TASK
let words = ["apple", "banana", "cherry", "date", "fig"]
let targetLetter: Character = "c"


if let firstString = findFirstStringStartingWith(targetLetter, in: words) {
    print("Первая строка, начинающаяся с буквы '\(targetLetter)': \(firstString)")
} else {
    print("Нет строк, начинающихся с буквы '\(targetLetter)'.")
}

func findFirstStringStartingWith(_ letter: Character, in strings: [String]) -> String? {
    return strings.first(where: { $0.first == letter })
}
