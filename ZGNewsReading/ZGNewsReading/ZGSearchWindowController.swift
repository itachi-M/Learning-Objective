//
//  ZGSearchWindowController.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/5/27.
//

import Cocoa
import WebKit

class ZGSearchWindowController: NSWindowController {
    
    @IBOutlet weak var webView: WKWebView!
    static let shareInstance: ZGSearchWindowController = ZGSearchWindowController.init(windowNibName: "ZGSearchWindowController")
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    func openWindow(urlString: String) {
        window?.makeKeyAndOrderFront(self)
        self.webView.load(URLRequest.init(url: URL.init(string: urlString)!))
    }
}
