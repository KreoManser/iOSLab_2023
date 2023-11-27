//
//  PublicationProtocol.swift
//  WorkWithUICollectionView
//
//  Created by Нияз Ризванов on 07.11.2023.
//

import Foundation

protocol PublicationProtocol: AnyObject {
    func asyncPublicationCurrentUser(user: User) async -> [Publication]
    func asyncDelete(_ publication: Publication)
    func asyncGetEverythingPublication() async -> [Publication]
    func asyncFind(withCriteria id: String, completion:
        @escaping (Publication?) -> Void)
    func asyncSave(_ publication: Publication, completion:
        @escaping (Bool) -> Void)
}
