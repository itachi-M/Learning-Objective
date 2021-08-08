//
//  ViewController.swift
//  SwiftLearningFour
//
//  Created by 刘铸耿 on 2021/4/4.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let s1 = Student(name: "b")
        let s2 = Student(name: "c", age: 2)
        let s3 = Student(name: "a", age: 1, sex: false)

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

