//
//  DataManagerProtocol.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 01.11.2023.
//

import Foundation

protocol DataManaging {
    /// synchronous version of methods
    func savePost(_ post: Posts)
    func retrievePost() -> [Posts]
    func searchPostByCaption(byCaption caption: String) -> [Posts]
    func deletePost(_ post: Posts)
    /// asynchronous version of methods
    func asyncSavePost(_ post: Posts, completion: @escaping(Bool) -> Void)
    func asyncRetrievePost(completion: @escaping([Posts]) -> Void)
    func asyncSearchPostsByCaption(byCaption caption: String, completion: @escaping(Posts?) -> Void )
    func asyncDeletePost(_ post: Posts, completion: @escaping(Bool) -> Void)
}
