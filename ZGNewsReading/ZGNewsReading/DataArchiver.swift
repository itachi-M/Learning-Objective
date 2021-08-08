//
//  DataArchiver.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/5/25.
//

import Foundation

class DataArchiver {
    class func saveModel(filePath: String, data: Any) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            do {
                _ = try data.write(to: URL(fileURLWithPath: filePath))
            } catch {
                print("data写入本地失败")
            }
        } catch {
            print("模型转data失败")
        }
    }
    class func loadModel(filePath: String) -> Any{
        do {
        let data = try Data.init(contentsOf: URL(fileURLWithPath: filePath))
            
        let model = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)

        return model

        } catch {
        print("获取data数据失败: \(error)")

        }
        return ""
    }
}
