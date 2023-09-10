import Cocoa

func moreThenFiveLenghtWords(mass: [String]) -> [String] {
    return mass.filter {$0.count > 5}
}

let words = ["apple", "banana", "carrot", "grapefruit", "orange"]
let filteredWords = moreThenFiveLenghtWords(mass: words)
print(filteredWords)
