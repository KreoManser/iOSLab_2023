import UIKit

var greeting = "Hello, playground"

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    var closure: (Int) -> Int = { a in
        return a
    }
    return backward ? stepBackward : closure
}

var choice = chooseStepFunction(backward: false)
var result = choice(10)
print(result)

var sortedClosure = { (s1: Int) -> Int in
    print(s1)
    return s1
 }
sortedClosure(22)

var names = ["1", "3", "4", "0", "10",]
names.sort()
names.sorted() {s1 ,s2 -> Bool in s1 < s2 } 
var sortNames = names.sorted(by: { $0 > $1 } )
print(sortNames)
print(names)
