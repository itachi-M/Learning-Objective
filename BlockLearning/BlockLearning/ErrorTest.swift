//
//  ErrorTest.swift
//  BlockLearning
//
//  Created by 刘铸耿 on 2021/6/8.
//

import Foundation

enum MyError: Error {
    case NumberOne
//    case NumberTwo
//    case NumberThree
}

class ErrorTest {
    
    var value = 1
    
    func testFunc(by block: (Int, Int) throws -> Void) rethrows -> Void {
        print("Hello")
        try block(value, value)
    }
}
