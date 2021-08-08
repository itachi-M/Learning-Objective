//
//  main.swift
//  leetcode
//
//  Created by 刘铸耿 on 2021/3/22.
//

import Foundation

print("Hello, World!")
let absences = [0, 2, 0, 4, 0, 3, 1, 0]
let test = absences.suffix(2)
let midpoint = absences.count / 2
let firstHalf = absences[..<midpoint]
let secondHalf = absences[midpoint...]
let firstHalfSum = firstHalf.reduce(0, +)
let secondHalfSum = secondHalf.reduce(0, +)
if firstHalfSum > secondHalfSum {
    print("More absences in the first half.")
} else {
    print("More absences in the second half.")
}
if let i = absences.firstIndex(where: {$0 > 0}) {
    print(i)
}

//let c1: Character = "1"
//let t1 = MemoryLayout.size(ofValue: c1)
//let t2 = MemoryLayout.alignment(ofValue: c1)
//let t3 = MemoryLayout.stride(ofValue: c1)
struct test111 {
    let value1: Int16 = 1
    let value3: Int16 = 1
    let value2: Int64 = 1
    let value4: Int16 = 1
}
let c1 = test111.init()
let t1 = MemoryLayout.size(ofValue: c1)
let t2 = MemoryLayout.alignment(ofValue: c1)
let t3 = MemoryLayout.stride(ofValue: c1)
let valueTest: Int32 = 1
print(MemoryLayout.alignment(ofValue: valueTest))
var array = [1, 2, 3, 4, 6, 7, 9, 10, 11]
let line = " BLANCHE:    I   don't want realism. I want magic!"
let result = line.split(maxSplits: 2, omittingEmptySubsequences: false) {
    $0 == " "
}
print(result)
let soul = Solution()
print(soul.subsetsWithDup([1, 2]))
