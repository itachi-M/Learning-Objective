//
//  ViewController.swift
//  indicatorViewTest
//
//  Created by 刘铸耿 on 2021/5/25.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var indicatorView: NSProgressIndicator!
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.startAnimation(self)
        indicatorView.stopAnimation(self)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

