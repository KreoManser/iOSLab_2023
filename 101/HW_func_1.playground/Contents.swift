import UIKit

func filterStringLength(from str: [String]) -> [String] {
    var newStringArray = str.filter {$0.count > 5}
    return newStringArray
}
var betaString = ["dog", "cat", "123456789", "0101010101", "12345"]
var filteredString = filterStringLength(from: betaString)
print(filteredString)

func filterEvenNumber(from nums: [Int]) -> [Int] {
    var newNumsArray = nums.filter { ($0 % 2) == 0 }
    return newNumsArray
}
var betaNums = [1, 2, -2, 8, 10, 9]
var filteredNumbers = filterEvenNumber(from: betaNums)
print(filteredNumbers)
