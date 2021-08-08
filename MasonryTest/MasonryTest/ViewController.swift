//
//  ViewController.swift
//  MasonryTest
//
//  Created by 刘铸耿 on 2021/3/26.
//

import Cocoa
import SnapKit

class ViewController: NSViewController {

    @IBOutlet weak var myTextField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = myTextField.font
        myTextField.stringValue = "asdahisdhashdajs大撒上的"
        myTextField.snp.makeConstraints { (make) in
            //make.lastBaseline.equalTo(50)
            make.top.equalTo(10)
            make.height.equalTo(20)
            make.left.equalTo(10)
        }
        myTextField.lineBreakMode = .byWordWrapping
        // Do any additional setup after loading the view.
        let stringTest: NSString = NSString.init(string: "Axyz独家")
        let size = stringTest.size(withAttributes: [NSAttributedString.Key.font : font])
        let para: NSMutableParagraphStyle = NSMutableParagraphStyle()
        let attributeString: NSMutableAttributedString = NSMutableAttributedString.init(string: myTextField.stringValue)
//        para.maximumLineHeight = 50.0
//        para.minimumLineHeight = 50.0
//        attributeString.addAttributes([NSAttributedString.Key.paragraphStyle: para, NSAttributedString.Key.baselineOffset : NSNumber.init(value: -10)], range: NSMakeRange(0, 5))
        attributeString.addAttributes([NSAttributedString.Key.baselineOffset: NSNumber.init(value: -2.0)], range: NSMakeRange(0, 5))
        myTextField.attributedStringValue = attributeString
        print(font?.pointSize)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

