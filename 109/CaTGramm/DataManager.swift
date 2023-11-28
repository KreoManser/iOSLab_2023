//
//  DataManager.swift
//  CaTGramm
//
//  Created by Rustem on 29.10.2023.
//

import Foundation
import UIKit

class DataManager: DataManagerProtocol {

    var dataSource: [PictureModel]

    var currentUser: User

    func syncSave(_ picture: PictureModel) {
        if let i = dataSource.firstIndex(where: { $0.id == picture.id }) {
            dataSource[i] = picture
            print("picture saved sync")
        }
    }

    func asyncSave(_ picture: PictureModel) {
        let operationQueue = OperationQueue()
        let saveOperation = BlockOperation {
            print("async saving started")
        }
        saveOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.id == picture.id }) {
                self.dataSource[i] = picture
                print("picture saved async")
            }
        }
        operationQueue.addOperation(saveOperation)
    }

    func syncGetAllPosts() -> [PictureModel] {
        return dataSource
    }

    func syncGetCurrentUserPosts() -> [PictureModel] {
        return dataSource.filter { $0.nickname == self.currentUser.userName }
    }

    func syncGetModel(_ picture: PictureModel) {
        if let i = dataSource.firstIndex(where: { $0.id == picture.id }) {
            print("\(i) is the index of this picture")
        }
    }

    func asyncGetModel(_ picture: PictureModel) {
        let operationQueue = OperationQueue()
        let getOperation = BlockOperation {
            print("async getting started")
        }
        getOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.id == picture.id }) {
                print("\(i) is the index of this picture")
            }
        }
        operationQueue.addOperation(getOperation)
    }

    func syncDeleteModel(_ picture: PictureModel) {
        if let i = dataSource.firstIndex(where: { $0.id == picture.id }) {
            dataSource.remove(at: i)
            print("picture deleted sync")
            print(dataSource.count)
        }
    }

    func asyncDeleteModel(_ picture: PictureModel) {
        let operationQueue = OperationQueue()
        let deleteOperation = BlockOperation {
            print("async deleting started")
        }
        deleteOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.id == picture.id }) {
                self.dataSource.remove(at: i)
                print("picture deleted async")
            }
        }
        operationQueue.addOperation(deleteOperation)
    }

    func syncSearchModel(_ name: String) {
        if let i = dataSource.firstIndex(where: { $0.text == name }) {
            print("\(dataSource[i]) is our post")
        }
    }

    func asyncSearchModel(_ name: String) {
        let operationQueue = OperationQueue()
        let deleteOperation = BlockOperation {
            print("async finding by desc started")
        }
        deleteOperation.completionBlock = {
            if let i = self.dataSource.firstIndex(where: { $0.text == name }) {
                print("\(self.dataSource[i]) is our post")
            }
        }
        operationQueue.addOperation(deleteOperation)
    }

    private init () {
        dataSource = []
        let instaImage = UIImage(named: "myava") ?? UIImage()
        let instaPicture = UIImage(named: "myava") ?? UIImage()
        dataSource.append(PictureModel(avatar: instaImage, nickname: "ТоповыйКотэ", picture: instaPicture, text: "Моя топовая ава"))
        dataSource.append(PictureModel(avatar: instaImage, nickname: "topovaya_murmurka", picture: instaPicture, text: "Моя топовая ава"))
        dataSource.append(PictureModel(avatar: instaImage, nickname: "topovaya_murmurka", picture: instaPicture, text: "Моя топовая ава"))
        dataSource.append(PictureModel(avatar: instaImage, nickname: "topovaya_murmurka", picture: instaPicture, text: "Моя топовая ава"))
        dataSource.append(PictureModel(avatar: instaImage, nickname: "topovaya_murmurka", picture: instaPicture, text: "Моя топовая ава"))
        currentUser = User(userName: "default", avatar: "default", password: "adsadaasdasdasdadadadadasd", profileDescription: "default")
    }

    public static var OurDataManager = DataManager()
}
