//
//  ViewController.swift
//  Homework8
//
//  Created by kerik on 19.11.2023.
//

import UIKit

class ViewController: UIViewController {

    let spaceView = SpaceView(frame: .zero)

    override func loadView() {
        view = spaceView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
}

