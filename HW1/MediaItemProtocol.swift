//
//  MediaItemProtocol.swift
//  HW1
//
//  Created by Kseniya Skvortsova on 13.09.2023.
//

import Foundation

protocol MediaItemProtocol {
    func createId(param:Int)
    func compareParam(paramId: Int, value: String)->Bool
    func toString()
}
