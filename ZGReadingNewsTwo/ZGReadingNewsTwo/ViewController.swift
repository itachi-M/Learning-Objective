//
//  ViewController.swift
//  ZGReadingNewsTwo
//
//  Created by 刘铸耿 on 2021/3/18.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    lazy var viewController: ZGViewController = {
        let viewController = ZGViewController.init()
        return viewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(viewController.view)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var view:NSTableCellView? = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier.init("asd"), owner: self) as? NSTableCellView
        if view == nil {
            view = NSTableCellView.init(frame: NSZeroRect)
        }
        view?.textField?.stringValue = "111"
        return view
    }
    
    
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 100.0
    }


}

