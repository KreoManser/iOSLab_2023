//
//  Extension UIViewController.swift
//  MyToDo
//
//  Created by Rustem on 02.10.2023.
//

import UIKit

extension UIViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func createCustomTitleView(contactName: String) -> UIView {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 280, height: 41)
        
        let nameLabel = UILabel()
        nameLabel.text = contactName
        nameLabel.textColor = .orange
        nameLabel.frame = CGRect(x: 80, y: 10, width: 220, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(nameLabel)
        
        return view
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal
        )
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}

