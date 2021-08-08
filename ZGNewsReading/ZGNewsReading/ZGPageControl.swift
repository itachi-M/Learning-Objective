//
//  ZGPageControl.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/4/17.
//

import Cocoa

class ZGPageControl: NSView {
    var numberOfPage: Int = 3
    var pageControlWidth: CGFloat = 12.0
    var pageControlSpacing: CGFloat = 7.5
    var pageControlRadius: CGFloat = 4.5 / 2.0
    var pageControlHeight: CGFloat = 1.5
    var mouseMovedAction: ((_ index: Int) -> Void)?
    var mouseDownAction: ((_ index: Int) -> Void)?
    var mouseHoverAction: ((_ index: Int) -> Void)?
    var rectArray: Array = [NSValue]()
    var currentPageIndex: Int = 0 {
        didSet {
            self.needsDisplay = true
        }
    }
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.addTrackingArea(NSTrackingArea.init(rect: NSMakeRect(0, 0, self.frame.width, self.frame.height),
                                                 options: [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow],
                                                owner: self,
                                             userInfo: nil))
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addTrackingArea(NSTrackingArea.init(rect: NSMakeRect(0, 0, self.frame.width, self.frame.height),
                                                 options: [.mouseEnteredAndExited, .mouseMoved, .activeInKeyWindow],
                                                owner: self,
                                             userInfo: nil))
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
        var totalWidth = CGFloat(numberOfPage - 1) * (pageControlSpacing + pageControlSpacing) + pageControlSpacing
        if self.frame.width < totalWidth {
            let radio = self.frame.width / totalWidth
            totalWidth *= radio
        }
        var leading = (self.frame.width - totalWidth) / 2.0
        let originY = (self.frame.height - pageControlHeight) / 2.0
        for pageIndex in 0..<numberOfPage {
            let rect: NSRect = NSMakeRect(leading, originY, pageControlWidth, pageControlHeight)
            rectArray.append(NSValue.init(rect: rect))
            if pageIndex == currentPageIndex {
                NSColor.black.set()
            } else {
                NSColor.gray.set()
            }
            let path: NSBezierPath = NSBezierPath.init(roundedRect: rect, xRadius: pageControlRadius, yRadius: pageControlRadius)
            path.fill()
            leading += pageControlSpacing + pageControlWidth
        }
    }
    override func mouseMoved(with event: NSEvent) {
        var eventPoint = event.locationInWindow
        eventPoint = self.convert(eventPoint, from: nil)
        for (index, rectData) in rectArray.enumerated() {
            if (eventPoint.x >= rectData.rectValue.origin.x) && (eventPoint.x <= rectData.rectValue.origin.x + rectData.rectValue.size.width) {
                self.currentPageIndex = index
                mouseMovedAction?(index)
                return;
            }
        }
    }
    override func mouseDown(with event: NSEvent) {
        var eventPoint = event.locationInWindow
        eventPoint = self.convert(eventPoint, from: nil)
        for (index, rectData) in rectArray.enumerated() {
            if (eventPoint.x >= rectData.rectValue.origin.x) && (eventPoint.x <= rectData.rectValue.origin.x + rectData.rectValue.size.width) {
                mouseDownAction?(index)
            }
        }
    }
}
