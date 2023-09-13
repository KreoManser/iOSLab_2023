//
//  MediaManager.swift
//  HW1
//
//  Created by Kseniya Skvortsova on 13.09.2023.
//

import Foundation

class MediaManager {
    
    var mediaTypes: [Int]=[0,1,2]
    //0,1,2 index-Book, Music, Movie
    var medias: [MediaItem]
    
    init(medias: [MediaItem]){
        self.medias=medias
    }
    
    init(){
        self.medias=[]
    }
    
    func add(item: MediaItem){
        let mitem=findInd(item: item)
        if(mitem<0){
            item.createId(param: medias.count)
            medias.append(item)
            item.toString()
        }
        else{
            print("This item is already exist")
            item.toString()
        }
    }
    
    func remove(item: MediaItem){
        let index=findInd(item: item)
        if index<0{
            print("There're no such item")
        }
        else{
            medias.remove(at:index)
        }
    }
    
    func equals(item1: MediaItem, item2: MediaItem)->Bool{
        if type(of: item1)==type(of: item2){
            if item1.name==item2.name{
                if item1.author==item2.author{
                    return true
                }
            }
        }
        return false
    }
    
    func findInd(item: MediaItem) -> Int {
        if medias.count>0{
            for i in (0...medias.count-1){
                if (equals(item1: medias[i], item2: item)){
                    return i
                }
            }
            return -1
        }
        return -1
    }
    
    func find(param: Int) {
        var currMedia: [MediaItem]=[]
        
        for i in medias{
            if i.id%10==param {
                currMedia.append(i)
            }
        }
        
        if currMedia.count==0{
            print("There're no such item")
        }
        else{
            findByParam(currMedia: currMedia)
        }
    }
    
    func findByParam(currMedia:[MediaItem]){
        print("Enter property")
        var num=0
        for i in currMedia[0].properties{
            num+=1
            print(String(num)+". "+i)
        }
        
        let input=readLine() ?? "0"
        var choice=Int(input) ?? 0
        choice=choice-1
        if (choice<=0 || choice>currMedia[0].properties.count){
            print("Incorrect input")
            findByParam(currMedia: currMedia)
        }
        
        else{
            print("Enter property value")
            let value=readLine() ?? " "
            
            for i in currMedia{
                if i.compareParam(paramId: choice, value: value){
                    i.toString()
                }
            }
        }
    }
}
