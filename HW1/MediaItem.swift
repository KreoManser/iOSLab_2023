//
//  MediaItem.swift
//  HW1
//
//  Created by Kseniya Skvortsova on 13.09.2023.
//

import Foundation

class MediaItem: MediaItemProtocol{
    var id: Int
    let name: String
    let author: String
    let dateOfCreation: String
    var properties: [String]=["id","name","author","date of creation"]
    
    init() {
        id=0
        print("Enter name")
        name=readLine() ?? "-"
        print("Enter author")
        author=readLine() ?? "-"
        print("Enter date of creation")
        dateOfCreation=readLine() ?? "-"
    }
    
    func createId(param:Int){
        id=param
    }
    
    func compareParam(paramId: Int, value: String)->Bool{
        switch paramId {
        case 0:
            return self.id==Int(value)
        case 1:
            return self.name==value
        case 2:
            return self.author==value
        case 3:
            return self.dateOfCreation==value
        default:
            return false
        }
    }
    
    func toString(){
        print(properties[0]+" "+String(id))
        print(properties[1]+" "+name)
        print(properties[2]+" "+author)
        print(properties[3]+" "+dateOfCreation)
    }
}
