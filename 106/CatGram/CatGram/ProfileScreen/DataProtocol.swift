//
//  DataProtocol.swift
//  CatGram
//
//  Created by Аделя Миннехузина on 01.11.2023.
//

import Foundation

protocol DataProtocol {
    func syncSave(_ post: Post)
    func asyncSave(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void)
    func syncDelete(_ post: Post)
    func asyncDelete(_ post: Post, completion: @escaping (Result<Void, Error>) -> Void)
    func syncGetAllPosts() -> [Post]
    func asyncGetAllPosts(completion: @escaping (Result<[Post], Error>) -> Void)
}
