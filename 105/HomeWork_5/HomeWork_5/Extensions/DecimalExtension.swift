//
//  DecimalExtension.swift
//  HomeWork_5
//
//  Created by Камил Хайрутдинов on 08.10.2023.
//

import Foundation

extension Decimal {
    static func ConvertStringWithComma(string: String?) -> Decimal {
        return Decimal(string: string!.replacingOccurrences(of: ",", with: ".")) ?? 0
    }
}
