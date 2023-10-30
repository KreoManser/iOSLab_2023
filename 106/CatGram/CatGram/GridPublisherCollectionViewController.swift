//
//  GridPublisherCollectionViewController.swift
//  CatGram
//
//  Created by Нияз Ризванов on 29.10.2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    private func setupCell() {
        // Создайте UIView и установите его фоновый цвет в красный
        let redView = UIView()
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(redView)

        // Настройте ограничения для UIView, чтобы она занимала всю ячейку
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            redView.topAnchor.constraint(equalTo: contentView.topAnchor),
            redView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

class MyCollectionViewController: UICollectionViewController {
    let cellReuseIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Зарегистрируйте вашу кастомную ячейку для использования в коллекции
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
}

//class GridPublisherCollectionViewController: UICollectionViewController {
//    
//    let itemsPerRow: CGFloat = 3
//    let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//        self.collectionView!.register(GridPublisherCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
//        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//    
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! GridPublisherCollectionViewCell
//        
//           cell.backgroundColor = UIColor.blue
//        
//           return cell
//       }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
//            let availableWidth = collectionView.frame.width - paddingSpace
//            let widthPerItem = availableWidth / itemsPerRow
//            return CGSize(width: widthPerItem, height: widthPerItem)
//        }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return sectionInsets
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return sectionInsets.left
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//            return sectionInsets.left
//        }
//}
