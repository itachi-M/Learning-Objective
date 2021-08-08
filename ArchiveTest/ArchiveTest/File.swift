//
//  File.swift
//  ArchiveTest
//
//  Created by 刘铸耿 on 2021/4/20.
//

import Foundation

class Student: NSObject, NSCoding, NSSecureCoding {
    var name: String?
    var age: Int?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        age = coder.decodeObject(forKey: "age") as? Int ?? 0
    }
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(age, forKey: "age")
    }
    static var supportsSecureCoding: Bool {
        return true
    }
}
