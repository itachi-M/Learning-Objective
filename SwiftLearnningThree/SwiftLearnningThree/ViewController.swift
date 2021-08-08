//
//  ViewController.swift
//  SwiftLearnningThree
//
//  Created by 刘铸耿 on 2021/3/19.
//

import Cocoa

protocol Container {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer //where Suffix.Item == Item
    func suffix(_ index: Int) -> Suffix
}

protocol TestWhere {
    var gg: Int { get }
}

extension Container where Item: TestWhere {
    func printHello ()-> Void {
        
    }
}

struct Stack: SuffixableContainer {
    var items = [Int]()
    mutating func append(_ item: Int) {
        items.append(item)
    }
    var count: Int {
        items.count
    }
    subscript(i: Int) -> Int {
        items[i]
    }
    func suffix(_ index: Int) -> DoubleStack {
        let doubleStack = DoubleStack()
        return doubleStack
    }
}

struct DoubleStack: SuffixableContainer {
    var items = [Double]()
    mutating func append(_ item: Double) {
        items.append(item)
    }
    var count: Int {
        items.count
    }
    subscript(i: Int) -> Double {
        items[i]
    }
    func suffix(_ index: Int) -> Stack {
        let stack = Stack()
        return stack
    }
}

//struct Stack<Element: Equatable>: Container {
//    // original Stack<Element> implementation
//    var items = [Element]()
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//    // conformance to the Container protocol
//    mutating func append(_ item: Element) {
//        self.push(item)
//    }
//    var count: Int {
//        return items.count
//    }
//    subscript(i: Int) -> Element {
//        return items[i]
//    }
//}

struct testStruct {
    var width: Float = 0.0
    var height: Int = 1
    init(gg: Float, hh: Int) {
        width = gg
        height = hh
    }
}

extension testStruct {
    init(first: Float, second: Float, third: Float) {
        //self.init(gg: first, hh: Int(second) + Int(third))
    }
}

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let x = testStruct.init(gg: 101.1, hh: 10)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

