//
//  File.swift
//  SLearning
//
//  Created by 刘铸耿 on 2021/8/8.
//

import Foundation

class Person {
    private static var HEIGHT_KEY = false
    var age: Int = 10
    
}

extension Person {
    
    var height: Int {
        
        get {
            objc_getAssociatedObject(self, &Person.HEIGHT_KEY) as? Int ?? 10
        }
    
        set {
            objc_setAssociatedObject(self, &Person.HEIGHT_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

//class ClassB: ClassA {
//    let y = 2
//}
