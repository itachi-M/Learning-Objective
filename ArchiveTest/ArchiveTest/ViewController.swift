//
//  ViewController.swift
//  ArchiveTest
//
//  Created by 刘铸耿 on 2021/4/20.
//

import Cocoa

class ViewController: NSViewController {

    var dataArray: Array<Student>? = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testStudentTypeTwo()
        decodeFromStudent()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
//    func loadDataFromLocal() -> Array<Student>? {
//        let dataArchiver = DataArchiver()
//        return dataArchiver.loadData()
//    }
    
    func testNornamlType() {
//        let arrayTest = [1, 2]
//        let pathString = "\(NSHomeDirectory())/documents/arrayFile"
//        do {
//            try NSKeyedArchiver.archivedData(withRootObject: arrayTest, requiringSecureCoding: true)
//        } catch {
//            print("归档失败")
//        }
//        let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: pathString), options: .alwaysMapped)
//        let arrayTwo = (try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!)) as? [Int]
//        print(arrayTwo)
    }
    func testStudentType() {
//        var arrayTest: Array<Student> = [Student]()
//        let s1 = Student.init(name: "张三", age: 19)
//        let s2 = Student.init(name: "李四", age: 20)
//        arrayTest.append(s1)
//        arrayTest.append(s2)
        let pathString = "\(NSHomeDirectory())/documents/arrayFile"
        //NSKeyedArchiver.archiveRootObject(arrayTest, toFile: pathString)
        let arrayTwo = NSKeyedUnarchiver.unarchiveObject(withFile: pathString) as? Array<Student>
        print(arrayTwo)
    }
    func testStudentTypeTwo() {
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath = (file as NSString).appendingPathComponent("UserAccount.archiver")
        let student1 = Student.init(name: "as", age: 10)
        let student2 = Student.init(name: "as", age: 10)
        var array = [Student]()
        array.append(student1)
        array.append(student2)
        print(filePath)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
            do {
                _ = try data.write(to: URL(fileURLWithPath: filePath))
            } catch {
                print("data写入本地失败")
            }
        } catch {
            print("模型转data失败")
        }
    }
    func decodeFromStudent() -> Any{
        let file = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let filePath = (file as NSString).appendingPathComponent("UserAccount.archiver")
        do {
        let data = try Data.init(contentsOf: URL(fileURLWithPath: filePath))
            
        let model = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Student]

        return model

        } catch {
        print("获取data数据失败: \(error)")

        }
        return Student(name: "asd", age: 19)
    }
}

