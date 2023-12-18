//
//  DarkThemeViewController.swift
//  homework_10
//
//  Created by Кирилл Щёлоков on 10.12.2023.
//

import UIKit

class DarkThemeViewController: UIViewController {

    private var darkThemeView: DarkThemeView?

    required init(navigationTitle: String) {
        super.init(nibName: nil, bundle: nil)
        setUpNavigationBar(navigationTitle: navigationTitle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDarkThemeView()
    }

    private func setUpDarkThemeView() {
        darkThemeView = DarkThemeView()
        view = darkThemeView
    }

    private func setUpNavigationBar(navigationTitle: String) {
        navigationItem.title = navigationTitle
    }
}
