import UIKit


// Создайте функцию, которая фильтрует только слова с длиной больше 5 символов из массива строк

func sortWordsOverFiveLeter(example: [String]) -> [String]{
    return example.filter{0$.count > 5}
}

//Напишите функцию, которая фильтрует только четные числа из массива целых чисел, используя filter

func sortWordsEvenLength(example: [Int]) -> [Int]{
    return example.filter{ 0$ % 2 == 0}
}
