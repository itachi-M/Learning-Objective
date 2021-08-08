//
//  Structures.swift
//  SwiftLearningFour
//
//  Created by 刘铸耿 on 2021/4/4.
//

import Foundation

struct Student {
    var name: String
    var age: Int?
    var sex: Bool = true
}

class ClassA {
    let constPropertyOneCA: Int
    let constPropertyTwoCA: Int = 30
    var propertyOneCA: Int = 99 {
        willSet {
            print("propertyOne will be set")
        }
        didSet {
            print("propertyOne did set")
        }
    }
    init() {
        constPropertyOneCA = 100
        functionOne()
    }
    init(addNumToPropertyOneCA: Int) {
        constPropertyOneCA = 100
        propertyOneCA += 10
    }
    init(divideNumToPropertyOneCA: Int) {
        constPropertyOneCA = 100
        propertyOneCA -= 10
    }
    convenience init(valueCA: Int) {
        self.init()
        propertyOneCA = valueCA
    }
    func functionOne() -> Void {
        print("functionOne")
    }
}

class ClassB: ClassA {
    let constPropertyOneCB: Int = 10
    var propertyOneCB: Int = 19
    var cacaulatePropertyOneCB: Int {
        get {
            propertyOneCB * 2
        }
        set {
            print(newValue)
        }
    }
//    override init() {
//        constPropertyOneCB = 9
//        super.init()
//        propertyOneCA = 10
//    }
    convenience init(addNumToPropertyOneCB: Int) {
        self.init(addNumToPropertyOneCA: 10)
        propertyOneCB += addNumToPropertyOneCB
    }
    convenience override init(addNumToPropertyOneCA: Int) {
        self.init(divideNumToPropertyOneCA: 10)
        propertyOneCA += addNumToPropertyOneCA * 2
    }
}
