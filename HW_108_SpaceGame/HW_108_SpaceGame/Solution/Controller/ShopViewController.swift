//
//  ShopViewController.swift
//  HW_108_SpaceGame
//
//  Created by Артур Миннушин on 23.11.2023.
//

import UIKit

class ShopViewController: UIViewController {

    var shopView = ShopView(frame: .zero)
    var player = Player.sigelton
    override func viewDidLoad() {
        super.viewDidLoad()
        shopView.player = player
        shopView.shopController = self
    }
    override func loadView() {
        view = shopView
    }
    func dismisShopController() {
        dismiss(animated: true, completion: nil)
    }
}
