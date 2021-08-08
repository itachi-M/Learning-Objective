//
//  ZGSearchWebViewController.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/5/27.
//

import Cocoa
import WebKit

class ZGSearchWebViewController: NSViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "www.baidu.com"
        self.webView.load(URLRequest.init(url: URL.init(string: urlString)!))
        // Do view setup here.
    }
    
}
