//
//  ZGTableCellView.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/3/13.
//

import Cocoa
import SnapKit
import Kingfisher

class ZGTableCellView: NSTableCellView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.initSubViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initSubViews() {
        self.addSubview(titleField)
        self.addSubview(descField)
        self.addSubview(tagField)
        self.addSubview(rightImageView)
        self.layoutSubViews()
    }
    
    func layoutSubViews() {
        titleField.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.height.equalTo(20)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(rightImageView.snp.left).offset(-20)
        }
        descField.snp.makeConstraints { (make) in
            make.top.equalTo(titleField.snp.bottom).offset(6)
            make.height.equalTo(35)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(rightImageView.snp.left).offset(-20)
        }
        rightImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.height.equalTo(80)
            make.right.equalTo(self).offset(-20)
            make.width.equalTo(110)
        }
        tagField.snp.makeConstraints { (make) in
            make.top.equalTo(descField.snp.bottom).offset(6)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
        }
    }
    
    var cellModel: ZGNewsModel? {
        didSet {
            if let model = cellModel {
                if let title = model.title {
                    titleField.stringValue = title
                }
                if let desc = model.desc {
                    descField.stringValue = desc.trimmingCharacters(in: .whitespaces)
                }
                if let pubDate = model.pubDate {
                    tagField.stringValue = pubDate
                }
                if let source = model.source {
                    if tagField.stringValue.count != 0 && source.count != 0 {
                        tagField.stringValue = tagField.stringValue.appending(" · ")
                    }
                    tagField.stringValue = tagField.stringValue.appending(source)
                }
                if let hasPicture = model.hasPicture {
                    let rightImageViewWidth = hasPicture ? 110 : 0
                    rightImageView.snp.updateConstraints { (make) in
                        make.width.equalTo(rightImageViewWidth)
                    }
                    let urlString = hasPicture ? model.pictureUrls?[0]["url"] as! String : "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Ffinance%2Fblackcat%2Fpc%2Fimg%2F1224_media4.png&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1624672349&t=072c3de4f378f313865458893e666ff1"
                    let url = URL(string: urlString)
                    rightImageView.kf.setImage(with: url)
                }
            }
        }
    }
    
    lazy var titleField: NSTextField = {
        let titleField = NSTextField()
        titleField.isBordered = false
        titleField.isEditable = false
        titleField.drawsBackground = true
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.lineBreakMode = .byTruncatingTail
        titleField.textColor = NSColor.black
        titleField.font = NSFont.systemFont(ofSize: 16)
        titleField.backgroundColor = NSColor.clear
        return titleField
    }()
    
    lazy var descField: NSTextField = {
        let descField = NSTextField()
        descField.isBordered = false
        descField.isEditable = false
        descField.drawsBackground = true
        descField.translatesAutoresizingMaskIntoConstraints = false
        descField.lineBreakMode = .byCharWrapping
        descField.cell?.truncatesLastVisibleLine = true
        descField.textColor = NSColor.gray
        descField.backgroundColor = NSColor.clear
        return descField
    }()
    
    lazy var tagField: NSTextField = {
        let tagField = NSTextField()
        tagField.isBordered = false
        tagField.isEditable = false
        tagField.drawsBackground = true
        tagField.translatesAutoresizingMaskIntoConstraints = false
        tagField.textColor = NSColor.gray
        tagField.font = NSFont.systemFont(ofSize: 14)
        tagField.backgroundColor = NSColor.clear
        return tagField
    }()
    
    lazy var rightImageView: NSImageView = {
        let rightImageView = NSImageView()
        rightImageView.imageScaling = .scaleAxesIndependently
        return rightImageView
    }()
}
