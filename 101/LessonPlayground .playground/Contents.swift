import UIKit

var greeting = "Hello, playground"
let someInt = 5
let someFloat: Float = 5.9

greeting = greeting + " Hello"
greeting += "Hello \(someInt)"

print("\(someInt + someInt)")
print(String(someInt))

/// Optionals, Force-unwrap

let someValue = Int("12")

if let someValue {
    let sum = someValue + 5
}

/// Collections

let array = ["heel", "heel 2", "heel 3"]
let array2: [String] = ["heel"]

var dict: Dictionary<String, Int> = ["key_1": 5]

var sumArray = array + array2

sumArray.append("func")
sumArray.remove(at: 0)

let first = array.first

Array(dict.keys)
dict.values
dict["key_2"] = 5

dict

for i in sumArray {
    print("Element: \(i)")
}

for object in sumArray.enumerated() {
    print("Element offset: \(object.offset), \nvalue: \(object.element)")
}

let range = Range.init(uncheckedBounds: (0, 5))

//for i in (0 ... 5).reversed() {
//    print("Element: \(i)")
//}

//for element in dict {
//    print("Element: \(i)")
//}

//while true {
//    
//}

var isFinished = false

//repeat {
//    
//    for i in 0 ... 2 {
//        print("Hey")
//        isFinished = true
//    }
//} while isFinished

array.forEach { _ in
    print("Hello")
}
let newArray = array.map { value in
    value + "1"
}

array.map({ $0 + "1" })

let someString: String = array.reduce(into: "") { partialResult, value in
    partialResult += value
}

someString

/// Class, Struct, Protocol

protocol MyProtocol {
    
    var name: String { get set }
    
    func someFunc() -> String
    
    func someFunc(param1: String, param2: Int)
    
    func someFunc(param1: String?)
}

extension MyProtocol {
    
    func someFunc() -> String {
        return "Something"
    }
    
    func newFunc() -> String {
        return "Hello"
    }
}

class Human {
    let lastName: String
    
    init(lastName: String) {
        self.lastName = lastName
    }
    
}

extension Int {
    func printMySelf() {
        print(self)
    }
}



class User: Human {
    
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        super.init(lastName: "Zalyalov")
    }
    
    func sayMyName() -> String {
        return name
    }
}

let user = User(name: "Max", age: 18)
user.sayMyName()

user.age.printMySelf()

protocol Somenew {
    
}

class MyProtocolImplementation: Human, MyProtocol, Somenew {
    
    var name: String = ""
    
    init(name: String) {
        self.name = name
        super.init(lastName: name)
    }
    
    func someFunc(param1: String, param2: Int) {
    
    }
    
    func someFunc(param1: String?) {
       
    }
}

struct SomeUser {
    let name: String
    let age: Int
    
    func someFunc() -> String {
        let someVale = 5
        var sum = 5 + 5
        return "\(sum)"
    }
    
    func someNewFunc(someParam: (() -> String)) {
        someParam()
    }
}

let user2 = SomeUser(name: "Max", age: 123)

user2.someNewFunc(someParam: user2.someFunc)
//user2.someNewFunc(someParam: user2.someFunc())

// Value - Struct
// Ref - class, func, closure

extension SomeUser {
    
}

//let mySomeUser = SomeUser(name: <#T##String#>, age: <#T##Int#>)
