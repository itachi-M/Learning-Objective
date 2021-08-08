//
//  EmptyContentStatusView.swift
//  indicatorViewTest
//
//  Created by 刘铸耿 on 2021/5/25.
//

import Cocoa

enum EmptyContentStatusType {
    case loading
    case loadFailed
}

class EmptyContentStatusView: NSView {
    
    var viewStatus: EmptyContentStatusType = .loading
    let indicatorView: NSProgressIndicator = {
        let indicator = NSProgressIndicator(frame: NSMakeRect(0, 0, 100, 100))
        indicator.style = .spinning
        indicator.controlSize = .regular
        indicator.sizeToFit()
        return indicator
    }()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    override init(frame frameRect: NSRect) {
        viewStatus = .loading
        super.init(frame: frameRect)
        self.addSubview(indicatorView)
    }
    required init?(coder: NSCoder) {
        viewStatus = .loading
        super.init(coder: coder)
    }
}
