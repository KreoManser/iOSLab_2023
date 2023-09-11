//
//  File.swift
//  Multimedia
//
//  Created by Mac on 2023-09-10.
//

import Foundation

func filterWords (array: [String]) -> [String] {
    array.filter{ $0.count > 5 }
}

func filterNumbers (array: [Int]) -> [Int] {
    array.filter{ $0 % 2 == 0 }
}
