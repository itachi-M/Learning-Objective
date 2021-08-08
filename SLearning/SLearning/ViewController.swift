//
//  ViewController.swift
//  SLearning
//
//  Created by 刘铸耿 on 2021/7/11.
//

import Cocoa

class ViewController: NSViewController {
    
    //var ca: ClassA = ClassB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(textView1)
//        view.addSubview(textView2)
        let pa = Person()
       // pa.height = 10
        print(pa.height)
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
//
//    private lazy var textView1: NSTextView = {
//        let textView = NSTextView.init(frame: NSMakeRect(0, 0, 100, 100))
//        textView.string = "iadkhaksjhdajshdkahsdk"
//        //textView.textContainerInset = NSMakeSize(0, 0)
//        return textView
//    }()
//
//    private lazy var textView2: NSTextView = {
//        let textView = NSTextView.init(frame: NSMakeRect(100, 100, 100, 100))
//        textView.string = "iadkhaksjhdajshdkahsdk"
//        textView.textContainerInset = NSMakeSize(10, 10)
//        //textView.textContainer?.lineFragmentPadding = 0
//        return textView
//    }()

}

