//
//  StringExtension.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 09.10.2023.
//

import Foundation

extension String {
    static func DecimalToString(value: Decimal) -> String {
        return String(describing: value).replacingOccurrences(of: ".", with: ",")
    }
}
