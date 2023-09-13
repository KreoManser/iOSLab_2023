//
//  Book.swift
//  HW1
//
//  Created by Kseniya Skvortsova on 13.09.2023.
//

import Foundation


class Book: MediaItem {
    let constId=0
    let numOfPages: Int
    
    override init() {
        print("Enter number of pages")
        let input=readLine() ?? "0"
        numOfPages=Int(input) ?? 0
        
        super.init()
        properties.append("number of pages")
    }
    
    override func createId(param:Int) {
        id=param*10+constId
    }
    
    override func compareParam(paramId: Int, value: String) -> Bool {
        if !super.compareParam(paramId: paramId, value: value){
            switch paramId {
            case 4:
                return self.numOfPages==Int(value)
            default:
                return false
            }
        }
        else{
            return false
        }
    }
    
    override func toString() {
        super.toString()
        print(properties[4]+" "+String(numOfPages))
    }
}
