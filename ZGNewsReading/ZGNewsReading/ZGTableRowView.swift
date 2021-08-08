//
//  ZGTableRowView.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/3/20.
//

import Cocoa

class ZGTableRowView: NSTableRowView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            let color = NSColor.init(calibratedRed: 234/255.0, green: 243/255.0, blue: 253/255.0, alpha: 1.0)
            color.setFill()
            color.setStroke()
            let selectionPath = NSBezierPath.init(roundedRect: dirtyRect, xRadius: 10, yRadius: 10)
            selectionPath.fill()
            selectionPath.stroke()
        }
    }
    
}
