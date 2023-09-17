//
//  main.swift
//  HomeWork_102.2
//
//  Created by Артур Миннушин on 18.09.2023.
//

import Foundation

print(findingTheFirstEvenNumber(numbers: [2,3,4,5,6,7]))
print(findingFirstStartingWithSpecificLetter(letter: "a", strings: ["an", "aa", "efwe"]))

func findingTheFirstEvenNumber(numbers: [Int]) -> Int? {
     numbers.first { $0 % 2 == 0 }
 }

 //* Нахождение первой строки, начинающейся с определенной буквы, в массиве строк
 func findingFirstStartingWithSpecificLetter(letter: Character, strings: [String]) -> String? {
     strings.first { $0.first == letter }
 }
