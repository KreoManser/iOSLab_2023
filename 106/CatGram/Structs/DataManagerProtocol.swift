//
//  DataManagerProtocol.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 01.11.2023.
//

import Foundation

protocol DataManaging {
    /// synchronous version of methods
    func savePost(_ post: Post)
    func retrievePost() -> [Post]
    func searchPostByCaption(byCaption caption: String) -> [Post]
    func deletePost(_ post: Post)
    /// asynchronous version of methods
    func asyncSavePost(_ post: Post, completion: @escaping(Bool) -> Void)
    func asyncRetrievePost(completion: @escaping([Post]) -> Void)
    func asyncSearchPostsByCaption(byCaption caption: String, completion: @escaping(Post?) -> Void )
    func asyncDeletePost(_ post: Post, completion: @escaping(Bool) -> Void)
}
