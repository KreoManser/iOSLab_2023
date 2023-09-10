import UIKit

// -----first task-----
func moreThanFiveLenghtWord(mass: [String]) -> [String] {
    return mass.filter {$0.count > 5}
}

let mass = ["aaaa", "aaaaaa", "aaaaa", "aaaaaaaaa", "aaaaaaaaa"]
print(moreThanFiveLenghtWord(mass: mass))


// -----second task-----

func onlyChetNumbs(mass: [Int]) -> [Int] {
    return mass.filter {$0 % 2 == 0}
}

let mass1 = [1, 2, 3, 4, 5, 6, 7]

print(onlyChetNumbs(mass: mass1))
