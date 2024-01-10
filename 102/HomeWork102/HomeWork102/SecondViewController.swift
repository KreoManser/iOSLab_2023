//
//  SecondViewController.swift
//  HomeWork102
//
//  Created by Ильмир Шарафутдинов on 24.12.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    let array: [Int] = [2, 5, 7, 2, 3, 6, 9]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImage.layer.cornerRadius = 100
        avatarImage.clipsToBounds = true

        guard let firstEven = firstEvenNumber(in: array) else {
            print("Нет элементов")
            return
        }
        print(firstEven)
    }
    
    @IBAction func exitButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func basketButton(_ sender: Any) {
        performSegue(withIdentifier: "vc4", sender: nil)
    }
    

    func firstEvenNumber(in array: [Int]) -> Int? {
        if let firstElement = array.first, firstElement % 2 == 0 {
            return firstElement
        }
        return nil
    }
}
