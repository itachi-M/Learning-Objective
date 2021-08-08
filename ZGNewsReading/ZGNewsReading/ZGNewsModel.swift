//
//  ZGNewsModel.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/3/20.
//

import Cocoa

class ZGNewsModel: NSObject, NSCoding, NSSecureCoding {
    var newsId: String?
    var pubDate: String?
    var title: String?
    var channelName: String?
    var desc: String?
    var source: String?
    var channelId: String?
    var link: String?
    var hasPicture: Bool?
    var pictureUrls: Array<Dictionary<String, Any>>?
    init(dictionary: Dictionary<String, Any>) {
        newsId = dictionary["id"] as? String
        pubDate = dictionary["pubDate"] as? String
        title = dictionary["title"] as? String
        channelName = dictionary["channelName"] as? String
        desc = dictionary["desc"] as? String
        source = dictionary["source"] as? String
        channelId = dictionary["channelId"] as? String
        link = dictionary["link"] as? String
        hasPicture = dictionary["havePic"] as? Bool
        pictureUrls = dictionary["imageurls"] as? Array<Dictionary<String, Any>>
//        pictureUrl = dictionary[""]
    }
    required init?(coder: NSCoder) {
        newsId = coder.decodeObject(forKey: "newsId") as? String
        pubDate = coder.decodeObject(forKey: "pubDate") as? String
        title = coder.decodeObject(forKey: "title") as? String
        channelName = coder.decodeObject(forKey: "channelName") as? String
        desc = coder.decodeObject(forKey: "desc") as? String
        source = coder.decodeObject(forKey: "source") as? String
        channelId = coder.decodeObject(forKey: "channelId") as? String
        link = coder.decodeObject(forKey: "link") as? String
        hasPicture = coder.decodeObject(forKey: "hasPicture") as? Bool
        pictureUrls = coder.decodeObject(forKey: "pictureUrls") as? Array<Dictionary<String, Any>>
    }
    func encode(with coder: NSCoder) {
        coder.encode(newsId, forKey: "newsId")
        coder.encode(pubDate, forKey: "pubDate")
        coder.encode(title, forKey: "title")
        coder.encode(channelName, forKey: "channelName")
        coder.encode(desc, forKey: "desc")
        coder.encode(source, forKey: "source")
        coder.encode(channelId, forKey: "channelId")
        coder.encode(link, forKey: "link")
        coder.encode(hasPicture, forKey: "hasPicture")
        coder.encode(pictureUrls, forKey: "pictureUrls")
    }
    static var supportsSecureCoding: Bool {
        return true
    }
}
