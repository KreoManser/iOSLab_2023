import UIKit

let arrayOfWords = ["Mummy" , "Hello" , "Daily" , "Love" ,"Morining"
, "Java" , "Filter" ,"Numbers"]

//function to check words with length five
func fiveWordLength(_ input: [String]){
    let lengthFive = arrayOfWords.filter{ item in
        return item.count == 5
    }
}
fiveWordLength(arrayOfWords)



var arrayOfNUmbers = [3,4,5,6,7,90,2,1,3,4,5,6,7,8,0]

//function to check if numbers are even
func evenNumberCheck(_ input: [Int]){
    let evenNumbers = arrayOfNUmbers.filter{ $0 % 2 == 0 }
}
evenNumberCheck(arrayOfNUmbers)


