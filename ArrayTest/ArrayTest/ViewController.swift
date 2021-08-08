//
//  ViewController.swift
//  ArrayTest
//
//  Created by 刘铸耿 on 2021/5/26.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var searchField: NSSearchField!
    
    lazy var searchPopover:NSPopover  = {
        let searchPopover = NSPopover.init()
        searchPopover.contentViewController = ZGSearchViewController.init()
        searchPopover.behavior = .transient
        return searchPopover
    }()
    
    lazy var windowController:ZGNewsWindowController = {
        let windowController = ZGNewsWindowController.init(windowNibName: "ZGNewsWindowController")
       return windowController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerSearchFieldButtonAction()
    }
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidAppear() {
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func registerSearchFieldButtonAction() {
        let searchFieldCell: NSSearchFieldCell = searchField.cell as! NSSearchFieldCell
        searchFieldCell.searchButtonCell?.target = self
        searchFieldCell.searchButtonCell?.action = #selector(clickSearchButton)
    }
    
    @objc func clickSearchButton() {
        searchPopover.show(relativeTo: searchField.searchButtonBounds, of: searchField, preferredEdge: NSRectEdge.maxY)
        windowController.window?.makeKeyAndOrderFront(self)
    }

}

