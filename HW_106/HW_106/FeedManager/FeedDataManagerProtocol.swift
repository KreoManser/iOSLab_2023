//
//  FeedDataManagerProtocol.swift
//  HW_106
//
//  Created by Азат Зиганшин on 05.11.2023.
//

import Foundation
import UIKit

protocol FeedDataManagerProtocol {

    func syncSavePublication(_ publication: Publication)
    func asyncSavePublication(_ publication: Publication) async

    func syncGetAllPublications() -> [Publication]
    func asyncGetAllPublications() async -> [Publication]

    func syncGetAllPublications(byUserId userId: UUID) -> [Publication]
    func asyncGetAllPublications(byUserId userId: UUID) async -> [Publication]

    func syncDeletePublication(withIndex index: Int)
    func asyncDeletePublication(withIndex index: Int) async
}
