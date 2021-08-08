//
//  ViewController.swift
//  BlockLearning
//
//  Created by 刘铸耿 on 2021/6/7.
//

import Cocoa

class ViewController: NSViewController {
    
    var testNumber = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        var testNames = names.sorted { (s1: String, s2: String) -> Bool in
            return s1 > s2
        }
        oneMore(than: &testNumber)
        let e1 = ErrorTest()
        do {
            try e1.testFunc { (x1, x2) in
                if x1 == 1 {
                    throw MyError.NumberOne
                }
                print(x1 + x2)
            }
        } catch {
            print("1")
        }
       
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
//    func oneMore(than number: inout Int) {
//        number += testNumber
//    }

}

