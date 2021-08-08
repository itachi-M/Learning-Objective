//
//  ZGScrollerView.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/4/18.
//

import Cocoa

class ZGScrollerView: NSScrollView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerNotification()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        registerNotification()
    }
    
    override func scrollWheel(with event: NSEvent) {
        self.nextResponder?.scrollWheel(with: event)
    }
    
    
    
    func registerNotification() {
        
    }
}
