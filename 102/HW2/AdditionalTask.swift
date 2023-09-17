//
//  AdditionalTask.swift
//  HW2
//
//  Created by Dmitry on 18.09.2023.
//

import UIKit
    
func firstOddNumber(array: [Int]) -> Int? {
    array.first{ $0 % 2 == 0 } ?? nil
}

func firstStringByFirstCharacter(array: [String]) -> String? {
    array.first{ $0.first == "a" } ?? nil
}


   





