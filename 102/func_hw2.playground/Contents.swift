import Foundation

//task 1
func firstEvenNumber(from nums: [Int]) -> Int? {
    return nums.first {$0 % 2 == 0}
}
let betaNums = [1, 2, -2, 8, 10, 9]
let alphaNums = [1, 3, 11, 9]
if let number = firstEvenNumber(from: alphaNums) {
    print("The found number: \(number)")
}
else {
    print("Not found")
}

//task 2
func firstString(letter: Character, array: [String]) -> String? {
    return array.first {$0.first == letter}
}
let betaStrings = ["cat", "dog", "panda", "owl", "horse", "cow"]
if let string = firstString(letter: "c", array: betaStrings) {
    print("The found string: \(string)")
}
else {
    print("Not found")
}
