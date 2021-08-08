//
//  DataArchiver.swift
////  ArchiveTest
////
////  Created by 刘铸耿 on 2021/4/20.
////
//
//import Foundation
//
//class DataArchiver {
//    var dataArray: Array<Student>?
//    class func saveModel(filePath: String, data: Any) {
//        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
//        let filePath = (file as NSString).appendingPathComponent(filePath)
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
//            do {
//                _ = try data.write(to: URL(fileURLWithPath: filePath))
//            } catch {
//                print("data写入本地失败")
//            }
//        } catch {
//            print("模型转data失败")
//        }
//    }
//    class func loadModel(filePath: String) -> Any{
//        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
//        let filePath = (file as NSString).appendingPathComponent(filePath)
//        do {
//        let data = try Data.init(contentsOf: URL(fileURLWithPath: filePath))
//            
//        let model = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
//
//        return model
//
//        } catch {
//        print("获取data数据失败: \(error)")
//
//        }
//        return nil
//    }
//}
