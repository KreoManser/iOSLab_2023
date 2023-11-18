//
//  ViewController.swift
//  MyGame(A Cat in space)
//
//  Created by Нияз Ризванов on 16.11.2023.
//

import UIKit

class GameViewController: UIViewController {

    var backgroundSpace1: UIImageView!
        var backgroundSpace2: UIImageView!

        override func viewDidLoad() {
            super.viewDidLoad()

            // Создаем два фона
            backgroundSpace1 = createBackground(imageName: "Space")
            backgroundSpace2 = createBackground(imageName: "Space")

            // Добавляем их на главное представление
            view.addSubview(backgroundSpace1)
            view.addSubview(backgroundSpace2)

            // Позиционируем второй фон рядом с первым
            backgroundSpace2.frame.origin.y = backgroundSpace1.frame.maxY

            // Запускаем анимацию движения фона
            moveBackground()
        }

        func createBackground(imageName: String) -> UIImageView {
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            imageView.contentMode = .scaleAspectFill
            return imageView
        }

        func moveBackground() {
            UIView.animate(withDuration: 10.0, delay: 0.0, options: .curveLinear, animations: {
                // Двигаем оба фона вниз
                self.backgroundSpace1.frame.origin.y -= self.view.bounds.height
                self.backgroundSpace2.frame.origin.y -= self.view.bounds.height
            }) { (finished) in
                // После завершения анимации сбрасываем положение фонов, чтобы создать бесконечный эффект
                self.backgroundSpace1.frame.origin.y = 0
                self.backgroundSpace2.frame.origin.y = self.backgroundSpace1.frame.maxY

                // Рекурсивно вызываем анимацию для бесконечности
                self.moveBackground()
            }
        }
}

