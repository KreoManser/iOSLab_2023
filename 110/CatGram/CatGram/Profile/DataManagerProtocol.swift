//
//  DataManagerProtocol.swift
//  CatGram
//
//  Created by Ruslan Kozlov on 02.11.2023.
//

import Foundation

protocol DataManagerProtocol {
    func syncSave(_ model: ProfilePublication)
    func asyncSave(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void)
    func syncDelete(_ model: ProfilePublication)
    func asyncDelete(_ model: ProfilePublication, completion: @escaping (Result<Void, Error>) -> Void)
    func syncGetAllPosts() -> [ProfilePublication]
    func asyncGetAllPosts(completion: @escaping (Result<[ProfilePublication], Error>) -> Void)
}
