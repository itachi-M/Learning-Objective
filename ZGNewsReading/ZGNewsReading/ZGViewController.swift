//
//  ViewController.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/3/13.
//

import Cocoa
import WebKit
import Alamofire
import AppKit

let kCellIdentifier = "cellIdentifier"
let kRowIdentifier = "rowIdentifier"

struct RequestParameters: Encodable {
    let showapi_appid: String = "566354"
    let showapi_sign: String = "75dbf0897821429d8f7c08937b4fb480"
    var maxResult = 20
    let needContent = 0
    let needHtml = 0
    var page = 1
    let needAllList = 0
    var channelId: String = ""
    init(channelModel: ZGChannelModel) {
        if let id = channelModel.channelId {
            channelId = id
        }
    }
}

class ZGViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, WKNavigationDelegate {
    

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var topScrollerView: NSScrollView!
    @IBOutlet weak var topScrollerPageControl: ZGPageControl!
    @IBOutlet weak var emptyContentStatusView: EmptyContentStatusView!
    

    
    var dataArray: Array<ZGNewsModel> {
        get {
            viewModel.dataArray.value
        }
    }
    var bannerViewArray: Array = [ZGBannerView]()
    var timer: Timer?
    var scrollAction: Int {
        get {
            10
        }
        set {
            self.topScrollerView.contentView.setBoundsOrigin(NSMakePoint(805, 0))
        }
    }
    var lastLoadTime: TimeInterval?
    var currentPage: Int = 0
    var lastLoadUrlString: String?
    var firstLoad: Bool = true
    var viewModel: ZGNewsViewModel = ZGNewsViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emptyContentStatusView.hintString = "加载失败，"
        emptyContentStatusView.clickString = "点击重试"
        emptyContentStatusView.clickAction = { () -> Void in
            if let urlString = self.lastLoadUrlString {
                //self.emptyContentStatusView.viewStatus = .loading
                self.webView.load(URLRequest.init(url: URL.init(string: urlString)!))
            }
        }
        self.preferredContentSize = view.frame.size
        tableView.delegate = self
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(didScroller), name: NSView.boundsDidChangeNotification, object: tableView.enclosingScrollView?.contentView)
        webView.navigationDelegate = self
        topScrollerView.hasVerticalScroller = false
        topScrollerView.hasHorizontalScroller = false
        topScrollerView.documentView?.setFrameSize(NSMakeSize(3385, 220))
        topScrollerPageControl.numberOfPage = 5
        topScrollerPageControl.wantsLayer = true
        topScrollerPageControl.layer?.backgroundColor = NSColor.white.cgColor
        topScrollerPageControl.mouseMovedAction = { [self] (_ index: Int) -> Void in
            self.endTimer()
            self.topScrollerView.contentView.setBoundsOrigin(NSMakePoint(CGFloat(805 + 425 * index), 0))
            self.initTimer()
        }
        for i in 0...7 {
            let bannerView = ZGBannerView.init(frame: NSMakeRect(CGFloat(i * 425), 0, 410, 220))
            bannerView.mouseDownAction = { (_ urlString: String) -> Void in
                self.webView.load(URLRequest.init(url: URL.init(string: urlString)! as URL))
                self.lastLoadUrlString = urlString
            }
            bannerViewArray.append(bannerView)
            topScrollerView.contentView.addSubview(bannerView)
        }
        self.topScrollerView.contentView.setBoundsOrigin(NSMakePoint(805, 0))
    }
    
    override func viewDidAppear() {
        let currentTime = NSDate.init().timeIntervalSince1970
        if let lastLoadTime = lastLoadTime {
            if currentTime - lastLoadTime >= 5 {
                viewModel.currentPage = 1
                self.firstLoad = true
                viewModel.loadNewsModelArrayFromLocal()
                tableView.enclosingScrollView?.contentView.setBoundsOrigin(NSMakePoint(0, 0))
            }
        } else {
            viewModel.loadNewsModelArrayFromLocal()
        }
        lastLoadTime = currentTime
    }
    
    func configViewModel() {
        viewModel.channelModel = channerlModel
        viewModel.dataArray.observe { (_: [ZGNewsModel]) -> Void in
            self.initTableView()
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    var channerlModel: ZGChannelModel? {
        didSet {
            configViewModel()
        }
    }
        
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var view:ZGTableCellView? = tableView.makeView(withIdentifier:NSUserInterfaceItemIdentifier.init(kCellIdentifier), owner: self) as? ZGTableCellView
        if view == nil {
            view = ZGTableCellView.init(frame: NSZeroRect)
        }
        if row >= 0 && row < self.dataArray.count {
            view?.cellModel = self.dataArray[row]
        }
        return view
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 105.0
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let model = dataArray[row]
        if let urlString = model.link {
            let url = NSURL.init(string: urlString)
            webView.load(URLRequest.init(url: url! as URL))
            lastLoadUrlString = urlString
        }
        return true
    }
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var view: ZGTableRowView? = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(kRowIdentifier), owner: self) as? ZGTableRowView
        if view == nil {
            view = ZGTableRowView()
        }
        return view
    }
    
    func initTimer() {
        endTimer()
        if self.topScrollerPageControl.currentPageIndex == 4 {
            self.topScrollerView.contentView.setBoundsOrigin(NSMakePoint(380, 0))
        }
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        if let timer = timer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    func endTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func timerFunc() {
        var rect = topScrollerView.contentView.bounds
        self.topScrollerPageControl.currentPageIndex += 1
        self.topScrollerPageControl.currentPageIndex %= 5
        rect.origin.x = CGFloat((Int(rect.origin.x) - 805 + 425) % (425 * 5) + 805)
        animationScrollTo(point: rect.origin)
        if self.topScrollerPageControl.currentPageIndex == 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.topScrollerView.contentView.setBoundsOrigin(NSMakePoint(380, 0))
            }
        }
    }
    
    func animationScrollTo(point: NSPoint) {
        NSAnimationContext.beginGrouping()
        NSAnimationContext.current.duration = 2.0
        topScrollerView.contentView.animator().setBoundsOrigin(point)
        NSAnimationContext.endGrouping()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.isHidden = false
        emptyContentStatusView.isHidden = true
        emptyContentStatusView.viewStatus = .loadSucess
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webView.isHidden = true
        emptyContentStatusView.isHidden = false
        emptyContentStatusView.viewStatus = .loading
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.isHidden = true
        emptyContentStatusView.isHidden = false
        emptyContentStatusView.viewStatus = .loadFailed
    }
    
    @objc func didScroller(notify: NSNotification) {
        guard notify.object as? NSClipView === tableView.enclosingScrollView?.contentView else {
            return
        }
        if let scrollerView = tableView.enclosingScrollView {
            if scrollerView.contentView.bounds.origin.y >= (CGFloat(dataArray.count) - 5) * 105 {
                viewModel.loadNewsModelArrayFromLocal()
            }
        }
    }
    
    func initTableView()  {
        DispatchQueue.main.async {
            if let urlString = self.dataArray[0].link {
                if self.firstLoad {
                    self.webView.load(URLRequest.init(url: (URL.init(string: urlString)!)))
                    self.lastLoadUrlString = urlString
                    self.initTimer()
                    var pictureDataIndex = -1
                    for newsModel in self.dataArray {
                        if let hasPicture = newsModel.hasPicture {
                            if hasPicture && self.firstLoad {
                                pictureDataIndex += 1
                                if pictureDataIndex >= 0 && pictureDataIndex <= 4{
                                    if pictureDataIndex == 0 {
                                        self.bannerViewArray[7].viewModel = newsModel
                                    }
                                    self.bannerViewArray[pictureDataIndex + 2].viewModel = newsModel
                                    if pictureDataIndex == 4 {
                                        self.bannerViewArray[1].viewModel = newsModel
                                    }
                                    if pictureDataIndex == 3 {
                                        self.bannerViewArray[0].viewModel = newsModel
                                    }
                                }
                            }
                        }
                    }
                    self.firstLoad = false
                }
            }
            self.tableView.reloadData()
        }
    }
}

