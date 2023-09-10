import UIKit
//Доп задания

//1)Фильтр длинных слов

func longWordFilter(words:[String]) -> [String]{
    return words.filter{ word in word.count > 5 }
}

//2)Фильтр четных чисел
func evenNumberFilter(numbers: [Int]) -> [Int]{
    return numbers.filter{ number in number % 2 == 0 }
}

