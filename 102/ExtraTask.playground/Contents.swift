import Foundation

func firstChetNumb (mass: [Int]) -> Int? { mass.first { $0 % 2 == 0} }

func firstStringStartingWithLetter (mass: [String], letter: Character) -> String? { mass.first {$0.first == letter } }

let mass1 = [1, 111, 343, 3444, 0]
let mass2 = ["eifvebfief", "qqqqqqq", "e33", "www"]

print(firstChetNumb(mass: mass1) ?? 0)
print(firstStringStartingWithLetter(mass: mass2, letter: "e") ?? "")
