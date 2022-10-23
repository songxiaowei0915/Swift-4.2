import UIKit

var a: Int?
var b: Int!

type(of: b)

class C { var b: Int! = 1}
type(of: C().b)

func sumFn(_ m: Int!, _ n: Int!) -> Int! {
    return m + n
}
type(of: sumFn)

var c = b as Int?

var e:[Int?] = []
typealias sum = (Int?, Int?)->Int?

var x: Int!
let y = x

type(of: y)

func id<T>(_ value: T) -> T { return value }
type(of: id(x))

func forcedResult() -> Int! { return x }
type(of: forcedResult)

class A: NSObject {}
class B {
    @objc var n: A! = A()
}

func getProperty(object: AnyObject) {
    type(of: object.n)
    
    if let n = object.n {
        type(of: n)
    }
}

getProperty(object: B())

func fn() throws -> Int! {
    return 1
}

if let value: Int = try? fn() {
    let n: Int = value
}

func switchDemo(_ input: String!) -> String {
    switch input {
    case let ouput?:
        return ouput
    default:
        return "nil"
    }
}

class D {}

let values: [Any]! = [D()]

let transformed = values!.map{ $0 as! D }

let intValues: [Int]! = [1]
intValues.map { $0 + 1}

func fn(_: Int?) {}

var intIUO: Int! = 1
var intOptional: Int? = 1

fn(intIUO)
fn(intOptional)

class E: NSObject {}
let iuoElment:E! = nil
let array:[Any] = [iuoElment as Any]

let nsArray = array as NSArray
nsArray[0]

if let value = nsArray[0] as? NSNull {
    print("Nil value")
}

var result = true
result.toggle()

enum Shape: CaseIterable {
    case rectangle
    case circle(Double)
    case triangle
    
    static func random<T: RandomNumberGenerator>(using generator: inout T) -> Shape {
        return self.allCases.randomElement(using: &generator)!
    }
    
    static func random() -> Shape {
        return self.allCases.randomElement()!
    }
}

extension Shape {
    public typealias AllCases = [Shape]
    
    public static var allCases: AllCases {
        return [Shape.rectangle, Shape.circle(1.1), Shape.rectangle]
    }
}

Shape.allCases

extension Optional: CaseIterable where Wrapped: CaseIterable {
    public static var allCases: [Wrapped?] {
        return Wrapped.allCases.map { $0 } + [nil]
    }
}

Shape?.allCases

Int.random(in: Int.min ... Int.max)
UInt8.random(in: 1 ... 255)
Double.random(in: 0 ... 1)

Bool.random()

func coin(count: Int) -> Void {
    var result = (head: 0, back: 0)
    
    for _ in 1 ... count {
        if Bool.random() {
            result.head += 1
        }
        else {
            result.back += 1
        }
    }
    
    print("Head: \(result.head) Back: \(result.back)")
}

coin(count: 1000)

var numbers = [1,2,3,4,5,6,7,8,9]
numbers.randomElement()
numbers.shuffled()


Shape.random()

@dynamicMemberLookup
enum JSON {
    case intValue(Int)
    case stringValue(String)
    case arrayValue(Array<JSON>)
    case dictionaryValue(Dictionary<String, JSON>)
}

extension JSON {
    var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        
        return nil
    }
    
    var intValue: Int? {
        if case .intValue(let str) = self {
            return str
        }
        
        return nil
    }
}

extension JSON {
    subscript(index: Int) -> JSON? {
        if case .arrayValue(let array) = self {
            return index < array.count ? array[index] : nil
        }
        
        return nil
    }
    
    subscript(key: String) -> JSON? {
        if case .dictionaryValue(let dic) = self {
            return dic[key]
        }
        
        return nil
    }
}

extension JSON {
    subscript(dynamicMember memeber: String) -> JSON? {
        if case .dictionaryValue(let dic) = self {
            return dic[memeber]
        }
        
        return nil
    }
}

let json = JSON.dictionaryValue([
    "series": .arrayValue([
        .dictionaryValue(["title": .stringValue("What's new in Swift 4.2?")]),
        .dictionaryValue(["count": .intValue(5)])
    ])
])

json["series"]?[0]?["title"]?.stringValue
json.series?[0]?.title?.stringValue
