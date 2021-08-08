//
//  ViewController.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/3/13.
//

import Cocoa
import WebKit
import Alamofire

struct channelParameters: Encodable {
    let showapi_appid: String = "566354"
    let showapi_sign: String = "75dbf0897821429d8f7c08937b4fb480"
}

class ViewController: NSViewController, NSTabViewDelegate {
    
    lazy var tabView: NSTabView = {
        let tabView = NSTabView.init()
        return tabView
    }()
    
    @IBOutlet weak var searchField: NSSearchField!
    
    lazy var searchPopover:NSPopover  = {
        let searchPopover = NSPopover.init()
        searchPopover.contentViewController = ZGSearchViewController.init()
        searchPopover.behavior = .transient
        return searchPopover
    }()
    
    var channelArray: Array = [ZGChannelModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerSearchFieldButtonAction()
        tabView.delegate = self
        tabView.tabPosition = .top
        tabView.tabViewBorderType = .bezel
        self.view.addSubview(tabView)
        self.tabView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(22)
            make.left.right.bottom.equalTo(self.view)
        }
        loadChannelArrayFromLocal()
    }
    
    func loadChannelArrayFromLocal() -> Void {
        let request = channelParameters()
        AF.request("https://route.showapi.com/109-34", method: .get, parameters: request).responseJSON { (response) in
            switch response.result {
            case.success(let success):
                let dict = success as? Dictionary<String, AnyObject>
                let resBody = dict?["showapi_res_body"] as? Dictionary<String, AnyObject>
                let channelList = resBody?["channelList"] as? Array<Dictionary<String, Any>>
                if let channelList = channelList {
                    for channelDict in channelList {
                        let channelModel = ZGChannelModel(dict: channelDict)
                        self.channelArray.append(channelModel)
                    }
                }
                DataArchiver.saveModel(filePath: FilePathManager.getChannelArrayFilePath(), data: self.channelArray)
            case.failure(let error):
                self.channelArray = DataArchiver.loadModel(filePath: FilePathManager.getChannelArrayFilePath()) as! [ZGChannelModel]
                print(error)
            }
            self.initTabView()
        }
    }
    
    func addTabViewItem(channelModel: ZGChannelModel) -> Void {
        let viewController = ZGViewController.init()
        viewController.channerlModel = channelModel
        let tabViewItem: NSTabViewItem = NSTabViewItem.init(viewController: viewController)
        if let channelName = channelModel.name {
            tabViewItem.label = channelName
        }
        tabView.addTabViewItem(tabViewItem)
    }
    
    func initTabView() {
        DispatchQueue.main.async {
            for (index, channelModel) in self.channelArray.enumerated() {
                if index == 5 {
                    break
                }
                self.addTabViewItem(channelModel: channelModel)
            }
        }
    }
    
    func registerSearchFieldButtonAction() {
        let searchFieldCell: NSSearchFieldCell = searchField.cell as! NSSearchFieldCell
        searchFieldCell.searchButtonCell?.target = self
        searchFieldCell.searchButtonCell?.action = #selector(clickSearchButton)
    }
    
    @objc func clickSearchButton() {
        let viewController = searchPopover.contentViewController as! ZGSearchViewController
        viewController.searchTitleString = searchField.stringValue
        searchPopover.show(relativeTo: searchField.searchButtonBounds, of: searchField, preferredEdge: NSRectEdge.maxY)
    }
}

