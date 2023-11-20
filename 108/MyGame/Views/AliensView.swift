//
//  AliensView.swift
//  MyGame
//
//  Created by Faki Doosuur Doris on 18.11.2023.
//

import UIKit

class AliensView: UIView {

    //lazy var aliens: [UIImageView] = [UIImageView()]
    lazy var aliens: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAliens()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpAliens() {
//        let numberOfAliens = 5
//        for alien in 0..<numberOfAliens {
//            let alienImage = UIImage(named: "alien3")
//            let alienView = UIImageView(image: alienImage)
//            alienView.frame = CGRect(x: CGFloat(50 * alien), y: 50, width: 40, height: 60)
//           // aliens.append(alienView)
//            addSubview(alienView)
//        }
        aliens.image = UIImage(named: "alien3")
        aliens.frame = CGRect(x: 50, y: 50, width: 40, height: 50)
        addSubview(aliens)
    }
}
