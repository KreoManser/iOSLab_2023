//  AdditionalTask
//  first.swift
//  Homework_2

import Foundation

//* Нахождение первого четного числа в массиве целых чисел
func findFirstEvenNumber(in numbers: [Int]) -> Int? {
    return numbers.first { $0 % 2 == 0 }
}

//* Нахождение первой строки, начинающейся с определенной буквы, в массиве строк
func findFirstStringStartingWith(letter: Character, in strings: [String]) -> String? {
    return strings.first { $0.first == letter }
}

