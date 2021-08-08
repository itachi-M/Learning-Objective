//
//  ZGViewController.swift
//  ZGReadingNewsTwo
//
//  Created by 刘铸耿 on 2021/3/19.
//

import Cocoa

class ZGViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        tableView.delegate = self
        tableView.dataSource = self
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
