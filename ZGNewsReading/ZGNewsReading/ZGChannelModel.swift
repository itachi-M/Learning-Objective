//
//  ZGChannel.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/3/18.
//

import Cocoa

class ZGChannelModel: NSObject, NSCoding, NSSecureCoding {
    var channelId: String?
    var name: String?
    init(channelId: String, name: String) {
        self.channelId = channelId
        self.name = name
    }
    init(dict: Dictionary<String, Any>) {
        self.channelId = dict["channelId"] as? String
        self.name = dict["name"] as? String
    }
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String
        channelId = coder.decodeObject(forKey: "channelId") as? String
    }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(channelId, forKey: "channelId")
    }
    static var supportsSecureCoding: Bool {
        return true
    }
}
