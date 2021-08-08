//
//  ViewController.swift
//  swfitLearningTwo
//
//  Created by 刘铸耿 on 2021/3/7.
//

import Cocoa

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

enum testEnum: CaseIterable {
    case first
    case two
    case third
}

struct Stack<Element> {
    <#fields#>
}


@propertyWrapper
struct TwelveOrLess {
    var number: Int {
        didSet {
            print("a")
        }
    }
    init() { self.number = 0 }
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

@propertyWrapper
struct SmallNumber {
    private var number: Int
    var projectedValue: Bool
    init() {
        self.number = 0
        self.projectedValue = false
    }
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}
struct SomeStructure {
    @SmallNumber var someNumber: Int
}

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
}

func someThrowingFunction(x: Int) throws -> Int {
    guard x == 1 else {
        throw VendingMachineError.firstError
    }
    return 2
}

class ViewController: NSViewController {
    @TwelveOrLess var height: Int
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var testStruct = TwelveOrLess()
        testStruct.number = 1
        let testStructTwo = SomeStructure()
        print(testStructTwo.$someNumber)
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // 打印“The point is now at (3.0, 4.0)”
        let classATest = ZGClassA()
        classATest.instanceValueOne = 12
        print(classATest.instanceValueOne)
        let classBTest = ZGClassB()
        classBTest.instanceValueOne = 13
        print(classBTest.instanceValueOne)
        print(classATest[2])
        let classATestTwo = ZGClassA.init(instanceValueTwo: 1)
        print(classATestTwo.instanceValueTwo)
        let structTestOne = Animal.init(species: "1")
        if let test = structTestOne {
            print(test.species)
        }
        if structTestOne != nil {
            print(structTestOne!.species)
        }
        let structSize = size()
        print(structSize.width)
        let classCTestOne = ZGClassC()
        let ufo = size()
        classCTestOne.residence = ufo
        if let x = classCTestOne.residence?.height {
            print(x)
        }
        do {
            try classCTestOne.getItem(value: "Hello")
        } catch VendingMachineError.secondErrorFunc(price: let x) {
            print("zhugeng: \(x)")
        } catch {
            print("ad")
        }
        if let tom = try? someThrowingFunction(x: 1) {
            print(tom)
        } else {
            print("hello")
        }
        var things = [Any]()
        let testArrayNum: Int? = 8
        things.append(testArrayNum!)
        var c1: Customer? = Customer(name: "zhugeng")
        var card1: CreditCard? = CreditCard(number: 100, customer: c1!)
        c1!.card = card1
        c1 = nil
        print("helloWord")
        let countryOne = Country(name: "a", capitalName: "ab")
        print(countryOne.capitalCity.country)
        var playerOneScore = 42
        var playerTwoScore = 30
        balance(&playerOneScore, &playerTwoScore)  // 正常
        print(testEnum.allCases)
    }

    func balance(_ x: inout Int, _ y: inout Int) {
        let sum = x + y
        x = sum / 2
        y = sum - x
    }

    // 错误：playerOneScore 访问冲突
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

