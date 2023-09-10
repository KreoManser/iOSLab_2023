// Фильтрация длинных слов
func filterLongWords(words: [String]) -> [String] {
    let filteredWords = words.filter { word in
        return word.count > 5
    }
    return filteredWords
}

// Фильтрация четных чисел
func filterEvenNumbers(numbers: [Int]) -> [Int] {
    let filteredNumbers = numbers.filter { number in
        return number % 2 == 0
    }
    return filteredNumbers
}
