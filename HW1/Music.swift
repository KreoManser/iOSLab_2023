//
//  Music.swift
//  HW1
//
//  Created by Kseniya Skvortsova on 13.09.2023.
//

import Foundation

class Music: MediaItem {
    let constId=1
    let duration: Int
    let style:String
    
    override init() {
        print("Enter duration (minutes)")
        let input=readLine() ?? "0"
        duration=Int(input) ?? 0
        print("Enter style")
        style=readLine() ?? "-"
        
        super.init()
        properties.append("duration")
        properties.append("style")
    }
    
    override func createId(param:Int) {
        id=param*10+constId
    }
    
    override func compareParam(paramId: Int, value: String) -> Bool {
        if !super.compareParam(paramId: paramId, value: value){
            switch paramId {
            case 4:
                return self.duration==Int(value)
            case 5:
                return self.style==value
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
        print(properties[5]+" "+style)
    }
}
