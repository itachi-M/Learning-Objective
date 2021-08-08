//
//  ZGBannerView.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/4/16.
//

import Cocoa
import SnapKit

class ZGBannerView: NSView {
    
    var mouseDownAction: ((_ urlString: String) -> Void)?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.addSubview(imageView)
        self.imageView.addSubview(titleField)
        self.layoutSubViews()
//        self.addTrackingArea(NSTrackingArea.init(rect: frameRect, options: .activeInKeyWindow, owner: self, userInfo: nil))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var viewModel: ZGNewsModel? {
        didSet {
            if let model = viewModel {
                if let title = model.title {
                    titleField.stringValue = title
                }
                if let hasPicture = model.hasPicture {
                    let urlString = hasPicture ? model.pictureUrls?[0]["url"] as! String : "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Ffinance%2Fblackcat%2Fpc%2Fimg%2F1224_media4.png&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624672349&t=072c3de4f378f313865458893e666ff1"
                    let url = URL(string: urlString)
                    imageView.kf.setImage(with: url)
                } else {
                    
                }
            }
        }
    }
    
    func layoutSubViews() {
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(13)
            make.right.left.bottom.equalTo(self)
        }
        titleField.snp.makeConstraints { (make) in
            make.bottom.equalTo(-16)
            make.height.equalTo(52)
            make.left.equalTo(20)
            make.width.equalTo(350)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        if let model = viewModel {
            if let urlLink = model.link {
                mouseDownAction?(urlLink)
            }
        }
    }
    
    lazy var imageView: NSImageView = {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleAxesIndependently
        imageView.wantsLayer = true
        imageView.layer?.cornerRadius = 10.0
        let url = URL(string: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Ffinance%2Fblackcat%2Fpc%2Fimg%2F1224_media4.png&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624672349&t=072c3de4f378f313865458893e666ff1")
        imageView.kf.setImage(with: url)
        return imageView
    }()
    
    lazy var titleField: NSTextField = {
        let titleField = NSTextField()
        titleField.isBordered = false
        titleField.isEditable = false
        titleField.drawsBackground = true
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.lineBreakMode = .byWordWrapping
        titleField.cell?.truncatesLastVisibleLine = true
        titleField.textColor = NSColor.white
        titleField.font = NSFont.systemFont(ofSize: 21)
        titleField.backgroundColor = NSColor.clear
        titleField.stringValue = "华为自动驾驶惊艳全场啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊"
        return titleField
    }()
}
