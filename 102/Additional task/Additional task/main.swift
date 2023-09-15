//
//  main.swift
//  Additional task
//
//  Created by surexnx on 15.09.2023.
//

import Foundation

let array = [1,3,4,5,2,1]

if let even = array.first(where: { $0 % 2 == 0}) {
    print(even)
}

let arrayWords = ["tolya", "marina", "avgustina", "akakiki"]

if  let firstChar = arrayWords.first(where: {$0.first! ==  "m"}){
    print(firstChar)
}
