//
//  FileManager.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/5/25.
//

import Foundation

class FilePathManager {
    class func getFilePath(channelModel: ZGChannelModel) -> String {
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath = (file as NSString).appendingPathComponent(channelModel.channelId!)
        return filePath
    }
    class func getChannelArrayFilePath() -> String {
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath = (file as NSString).appendingPathComponent("Archiver.ChannelArray")
        return filePath
    }
}

