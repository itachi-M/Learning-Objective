//
//  EmptyContentStatusView.swift
//  indicatorViewTest
//
//  Created by 刘铸耿 on 2021/5/25.
//

import Cocoa
import SnapKit

enum EmptyContentStatusType {
    case loading
    case loadFailed
    case loadSucess
}

class EmptyContentStatusView: NSView, NSTextViewDelegate {
    
    var viewStatus: EmptyContentStatusType = .loading {
        didSet {
            switch viewStatus {
            case .loading:
                startAnimationProgressIndicator()
                textView.isHidden = true
            case .loadSucess:
                stopAnimationProgressIndicator()
                isHidden = true
                textView.isHidden = true
            case .loadFailed:
                stopAnimationProgressIndicator()
                textView.isHidden = false
//            default:
//                stopAnimationProgressIndicator()
            }
        }
    }
    
    var hintString: String = "加载失败" {
        didSet {
            
        }
    }
    
    var clickAction: (() -> Void)?
    
    var clickString: String = "点击重试" {
        didSet {
            let attributedHintClickString: NSMutableAttributedString = NSMutableAttributedString.init(string: hintString.appending(clickString))
            attributedHintClickString.addAttribute(.link, value: "clikString", range: NSMakeRange(hintString.count, clickString.count))
            hintClickString = attributedHintClickString
        }
    }
    
    var hintClickString: NSAttributedString = NSAttributedString.init() {
        didSet {
            textView.textStorage?.setAttributedString(hintClickString)
            let size = hintClickString.boundingRect(with: NSMakeSize(9999, 9999), options: [.usesFontLeading, .truncatesLastVisibleLine], context: nil)
            textView.snp.updateConstraints { (make) in
                make.height.equalTo(size.height)
                make.width.equalTo(size.width + 10)
            }
        }
    }

    lazy var indicatorView: NSProgressIndicator = {
        let indicator = NSProgressIndicator(frame: NSMakeRect(0, 0, 100, 100))
        indicator.style = .spinning
        indicator.controlSize = .regular
        indicator.sizeToFit()
        indicator.layer?.backgroundColor = NSColor.white.cgColor
        return indicator
    }()
    
    lazy var textView: NSTextView = {
        let textView = NSTextView()
        textView.isHidden = true
        textView.isEditable = false
        return textView
    }()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Drawing code here.
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubViews()
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
    }
    
    func startAnimationProgressIndicator() {
        indicatorView.isHidden = false
        indicatorView.startAnimation(nil)
    }
    
    func stopAnimationProgressIndicator() {
        indicatorView.isHidden = true
        indicatorView.stopAnimation(nil)
    }
    
    func initSubViews() {
        addSubview(indicatorView)
        addSubview(textView)
        layoutSubViews()
    }
    
    func layoutSubViews() {
        indicatorView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        textView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        configSubViews()
    }
    
    func configSubViews() {
        textView.delegate = self
    }
    
    func textView(_ textView: NSTextView, clickedOnLink link: Any, at charIndex: Int) -> Bool {
        clickAction?()
        return true
    }
}
