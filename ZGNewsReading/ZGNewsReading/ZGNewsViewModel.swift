//
//  ZGNewsViewModel.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/5/26.
//

import Foundation
import Alamofire

class ZGNewsViewModel {
    
    var dataArray: Observable<[ZGNewsModel]> = Observable([])
    var currentPage: Int = 0
    var channelModel: ZGChannelModel?
    var isRequesting: Bool = false
    
    func loadNewsModelArrayFromLocal() -> Void {
        guard let requestModel = channelModel else {
            print("channelModel为空")
            return
        }
        guard !isRequesting else {
            return
        }
        isRequesting = true
        var request = RequestParameters(channelModel: requestModel)
        request.page = currentPage
        var tempArray = [ZGNewsModel]()
        if currentPage > 1{
            request.maxResult = 10
            tempArray = DataArchiver.loadModel(filePath: FilePathManager.getFilePath(channelModel: requestModel)) as! [ZGNewsModel]
        }
        AF.request("https://route.showapi.com/109-35", method: .get, parameters: request).responseJSON{ response in
            self.isRequesting = false
            switch response.result {
            case.success(let value):
                self.currentPage += 1
                print(value)
                let dict = value as? Dictionary<String, AnyObject>
                let showapiResBody = dict?["showapi_res_body"] as? Dictionary<String, AnyObject>
                let pagebean = showapiResBody?["pagebean"] as? Dictionary<String, AnyObject>
                let contentlist = pagebean?["contentlist"] as? Array<Dictionary<String, Any>>
                if let contentListArray = contentlist {
                    for newsContent in contentListArray {
                        tempArray.append(ZGNewsModel(dictionary: newsContent))
                    }
                }
                DataArchiver.saveModel(filePath: FilePathManager.getFilePath(channelModel: requestModel), data: tempArray)
            case.failure(let error):
                print(error)
            }
            self.dataArray.value = DataArchiver.loadModel(filePath: FilePathManager.getFilePath(channelModel: requestModel)) as! [ZGNewsModel]
        }
    }
}
