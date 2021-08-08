//
//  ZGClassA.swift
//  swfitLearningTwo
//
//  Created by 刘铸耿 on 2021/3/7.
//

import Cocoa

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    //typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

func functionGetValue() -> Int {
    return 10
}

struct size {
    let height: Int = functionGetValue()
    let width: Int = {(x: Int, y: Int) -> Int in
        return x + y
    }(1, 2)
}

class ZGClassA: NSObject {
    static var classValueOne: Int = 0
    var instanceValueTwo: Int
    let constValue: Int = 0
    var readOnlyInstanceValue: Int {
        get {
            return 1
        }
    }
    var instanceValueOne: Int {
        get {
            return 10
        }
        set {
            if (newValue > 10) {
                self.instanceValueOne = 10
            }
        }
    }
    static func classMethodOne(addNumber: Int) {
        classValueOne += addNumber
    }
    subscript(index: Int) -> Int {
         instanceValueOne * index
    }
    override init() {
        self.instanceValueTwo = 1
        super.init()
    }
    init(instanceValueTwo: Int) {
        self.instanceValueTwo = instanceValueTwo
        super.init()
    }
}

class ZGClassB: ZGClassA {
    let classBConstValue: Int = 1
    var classBCaluteValue: Int
    override init() {
        self.classBCaluteValue = 1
        super.init()
        self.instanceValueTwo = 2
    }
    convenience init(number: Int) {
        self.init()
    }
}

struct Item {
    var price: Int
    var count: Int
}

class ZGClassC: NSObject {
    var residence: size?
    var dictionary = [
        "Candy Bar": Item(price: 1, count: 2),
        "Hello": Item(price: 2, count: -3),
        "Decade": Item(price: 3, count: 4)
    ]
    func getItem(value: String) throws {
        guard let item = dictionary[value] else {
            throw VendingMachineError.firstError
        }
        guard item.count > 0 else {
            throw VendingMachineError.secondErrorFunc(price: item.count)
        }
        guard item.price > 0 else {
            throw VendingMachineError.thirdError
        }
    }
}

enum VendingMachineError: Error {
    case firstError
    case secondErrorFunc(price: Int)
    case thirdError
}

