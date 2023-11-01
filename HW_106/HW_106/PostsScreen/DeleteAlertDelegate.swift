//
//  DeleteAlertDelegare.swift
//  HW_106
//
//  Created by Азат Зиганшин on 01.11.2023.
//

import Foundation

protocol DeleteAlertDelegate: AnyObject {
    func presentDeleteAlert(_ indexPath: IndexPath)
}
