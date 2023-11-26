//
//  FriendsViewController.swift
//  CatGram
//
//  Created by Faki Doosuur Doris on 26.11.2023.
//

import UIKit

class FriendsViewController: UIViewController {
    var friendsView: FriendsView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }

    private func setUpView() {
        friendsView = FriendsView(frame: view.bounds)
        view = friendsView
    }

}
