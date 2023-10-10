import UIKit;

/// Класс для представления модели корзины.
internal class ShoppingCart {
    /// Массив для хранения машин, добавленных в корзину.
    internal var cars: [Car] = [];
    
    /// Closure для подсчета итоговой стоимости корзины,
    /// принимает итоговую стоимость (total) и машину (car).
    private var totalPriceCalculation: (Double, Car) -> Double = { total, car in
        return total + car.price;
    }
    
    /// Метод добавления машины в корзину (массив cars).
    func addCar(_ car: Car) {
        cars.append(car);
    }
    
    /// Метод удаления машины из корзины (массив cars).
    func removeCar(at index: Int) {
        cars.remove(at: index);
    }
    
    /// Метод для подсчета итоговой стоимости корзины
    /// (тут вызывается Closure totalPriceCalculation).
    func calculateTotalPrice() -> String {
        var totalPrice: Double = 0.0;

        for car in cars {
            totalPrice = totalPriceCalculation(totalPrice, car);
        }
        
        // Форматируем все в строку, чтобы легче было передавать в totalPriceLabel в ShoppingCartViewController
        let formattedPrice = String(format: "%.2f", totalPrice)

        return "Total: $\(formattedPrice)"
    }
}
