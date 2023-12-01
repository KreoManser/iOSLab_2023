//
//  ButtonsHandler.swift
//  KittyGram
//
//  Created by Камил Хайрутдинов on 01.12.2023.
//

import Foundation

class ButtonsHandler {

    let settingsButton: [SettingButton] = [
        SettingButton(imageName: "microbe", title: "Сменить тему"),
        SettingButton(imageName: "door.left.hand.open", title: "Выйти из аккакнта")
    ]

    private init() { }

    static let shared = ButtonsHandler()
}
