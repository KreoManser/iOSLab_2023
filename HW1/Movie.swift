//
//  Movie.swift
//  HW1
//
//  Created by Kseniya Skvortsova on 13.09.2023.
//

import Foundation


class Movie: MediaItem{
    let constId=2
    let duration: Int
    
    override init() {
        print("Enter duration (minutes)")
        let input=readLine() ?? "0"
        duration=Int(input) ?? 0
        
        super.init()
        properties.append("duration")
    }
    
    override func createId(param:Int) {
        id=param*10+constId
    }
    
    override func compareParam(paramId: Int, value: String) -> Bool {
        if !super.compareParam(paramId: paramId, value: value){
            switch paramId {
            case 4:
                return self.duration==Int(value)
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
        print(properties[4]+" "+String(duration))
    }
}
