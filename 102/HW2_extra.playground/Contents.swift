import Cocoa

let arr1:[Int]=[5,6,7,8,9,10]
let arr2:[String]=["er", "ty", "ae", "uu", "aaa"]
let symbol: Character="a"

func firstEven(arr:[Int]) -> Int?{
    return arr.first(where: { $0 % 2==0 })
}

func firstWithSymbol(arr:[String], symbol: Character) -> String?{
    return arr.first(where: {$0.firstIndex(of: symbol) == $0.startIndex})
}

print(firstEven(arr: arr1))
print(firstWithSymbol(arr: arr2, symbol: symbol))
