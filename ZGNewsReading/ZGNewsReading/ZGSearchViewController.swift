//
//  ZGSearchViewController.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/5/27.
//

import Cocoa
import Alamofire

struct SearchParameters: Encodable {
    let showapi_appid: String = "566354"
    let showapi_sign: String = "75dbf0897821429d8f7c08937b4fb480"
    var maxResult = 10
    let needContent = 0
    let needHtml = 0
    var page = 1
    let needAllList = 0
    var title = ""
}

class ZGSearchViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: NSTableView!
    
    var dataArray: [ZGNewsModel] = []
    var searchDefaultParameter = SearchParameters()
    var searchTitleString = "" {
        didSet {
            searchDefaultParameter.title = searchTitleString
            dataArray = []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.doubleAction = #selector(tableViewDidDoubleClick)
    }
    
    override func viewDidAppear() {
        AF.request("https://route.showapi.com/109-35", method: .get, parameters: searchDefaultParameter).responseJSON{ response in
            switch response.result {
            case.success(let value):
                print(value)
                let dict = value as? Dictionary<String, AnyObject>
                let showapiResBody = dict?["showapi_res_body"] as? Dictionary<String, AnyObject>
                let pagebean = showapiResBody?["pagebean"] as? Dictionary<String, AnyObject>
                let contentlist = pagebean?["contentlist"] as? Array<Dictionary<String, Any>>
                if let contentListArray = contentlist {
                    for newsContent in contentListArray {
                        self.dataArray.append(ZGNewsModel(dictionary: newsContent))
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
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
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        var view: ZGTableRowView? = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier.init(kRowIdentifier), owner: self) as? ZGTableRowView
        if view == nil {
            view = ZGTableRowView()
        }
        return view
    }
    
    @objc func tableViewDidDoubleClick() {
        let model = dataArray[tableView.selectedRow]
        if let link = model.link {
            ZGSearchWindowController.shareInstance.openWindow(urlString: link)
        }
    }
}
