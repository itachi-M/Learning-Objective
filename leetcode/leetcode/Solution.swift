//
//  Solution.swift
//  leetcode
//
//  Created by 刘铸耿 on 2021/3/22.
//

import Cocoa

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class BSTIterator {
    private var stack: [TreeNode] = []
    init(_ root: TreeNode?) {
        guard let root = root else {
            return
        }
        preLoad(root)
    }
    
    func preLoad(_ node: TreeNode) {
        stack.append(node)
        var tempNode: TreeNode? = node.left
        while tempNode != nil {
            stack.append(tempNode!)
            tempNode = tempNode?.left
        }
    }
    func next() -> Int {
        let node = stack.removeLast()
        if let nodeRight = node.right {
            preLoad(nodeRight)
        }
        return node.val
    }
    
    func hasNext() -> Bool {
        if stack.count == 0 {
            return false
        } else {
            return true
        }
    }
}


class Solution: NSObject {
    func transpose(_ matrix: [[Int]]) -> [[Int]] {
        let n = matrix.count
        let m = matrix[0].count
        var answer = [[Int]].init(repeating: [Int].init(repeating: 0, count: m), count: n)
        for i in 0..<n {
            for j in 0..<m {
                answer[i][j] = matrix[j][i]
            }
        }
        return answer
    }
    func sortedSquares(_ nums: [Int]) -> [Int] {
        let ans = nums.sorted{ $0 * $0 < $1 * $1}.map {
            return $0 < 0 ? -$0 : $0
        }
        return ans
    }
    func sumOddLengthSubarrays(_ arr: [Int]) -> Int {
        let n = arr.count
        var ans = 0
        for i in 1...(n + 1) / 2 {
            for j in 0..<n {
                let minEnd = j - min(j + 1, 2 * i - 1) + 1 + 2 * i - 2
                let minNum = max(min(n, j + 2 * i - 2) - minEnd, 0) + 1
                ans += arr[j] * minNum
            }
        }
        return ans
    }
    func majorityElement(_ nums: [Int]) -> Int {
        var voteNum = 0, vote = -1
        for num in nums {
            if voteNum == 0 {
                vote = num
                voteNum += 1
            } else if num != vote{
                voteNum -= 1
            } else {
                voteNum += 1
            }
        }
        if voteNum == 0 {
            return -1
        }
        let ans = nums.map{ $0 == vote ? 1 : 0}
        return (ans.reduce(0, +) >= nums.count / 2 + 1) ? vote : -1
    }
    func maximumProduct(_ nums: [Int]) -> Int {
        var maxNum1 = -1001, maxNum2 = -1001, maxNum3 = -1001, minNum1 = 1001, minNum2 = 1001
        for num in nums {
            if maxNum1 < num {
                maxNum3 = maxNum2
                maxNum2 = maxNum1
                maxNum1 = num
            } else if maxNum2 < num {
                maxNum3 = maxNum2
                maxNum2 = num
            } else if maxNum3 < num {
                maxNum3 = num
            }
            
            if minNum1 > num {
                minNum2 = minNum1
                minNum1 = num
            } else if minNum2 > num {
                minNum2 = num
            }
        }
        return max(maxNum1 * maxNum2 * maxNum3, minNum1 * minNum2 * maxNum1)
    }
    func threeConsecutiveOdds(_ arr: [Int]) -> Bool {
        let arrFlag = arr.map{($0 & 1) == 1 ? 0 : 1}
        if arr.count < 3 {
            return false
        }
        var first = arrFlag[0], second = arrFlag[1], third = arrFlag[2]
        if first + second + third == 0 {
            return true
        }
        for num in 3..<arrFlag.count{
            first = second
            second = third
            third = arrFlag[num]
            if first + second + third == 0 {
                return true
            }
        }
        return false
    }
    struct numAndIndex {
        let num: Int
        let index: Int
    }
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var numsSet: Set<Int> = Set.init()
        for index in 0..<nums.count {
            if numsSet.contains(nums[index]) {
                return true
            }
            numsSet.insert(nums[index])
            if numsSet.count > k + 1{
                numsSet.remove(nums[index-k])
            }
        }
        return false
    }
    func summaryRanges(_ nums: [Int]) -> [String] {
        var newNums: [Int] = Array.init(nums)
        newNums.append(nums.last!)
        var begin = newNums[0], end = newNums[0]
        var ansArray = [String]()
        for index in (newNums.startIndex + 1)..<newNums.endIndex {
            if newNums[index] != newNums[index-1] + 1 {
                end = newNums[index-1]
                ansArray.append(begin == end ? String.init("\(begin)") : String.init("\(begin)->\(end)"))
                begin = newNums[index]
            } else {
                end = newNums[index]
            }
        }
        return ansArray
    }
    func reverseBits(_ n: Int) -> Int {
        var ans: Int64 = 0
        var num = n
        for _ in 0..<32 {
            if num&1 != 0 {
                ans = ans * 2 + 1
            }
            num >>= 1
        }
        return Int(ans)
    }
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        var maxNum = 0
        var oneFlag = 0
        let flowerbedNew: [Int] = [1, 0] + flowerbed + [0, 1]
        for num in flowerbedNew {
            if num == 1 {
                maxNum += (oneFlag-1)/2
            } else {
                oneFlag += 1
            }
        }
        return maxNum >= n
    }
    func flipAndInvertImage(_ image: [[Int]]) -> [[Int]] {
        var ans: [[Int]] = Array.init(repeating: [Int].init(repeating: 0, count: image[0].count), count: image.count)
        let n = image.count, m = image[0].count
        for i in 0..<n {
            for j in 0..<m {
                ans[i][j] = image[i][m-1-j]
            }
        }
        ans = ans.map { $0.map{ $0 == 0 ? 1: 0}}
        return ans
    }
    func maximumWealth(_ accounts: [[Int]]) -> Int {
        var ans = 0
        for subAccount in accounts {
            ans = max(ans, subAccount.reduce(0, +))
        }
        return ans
    }
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var newNums = Array.init(repeating: 0, count: 21)
        for num in nums {
            newNums[num + 10] += 1
        }
        var ans: [[Int]] = []
        var subAns: [Int] = []
        subSets(newNums, 0, &subAns, &ans)
        return ans
    }
    func subSets(_ countArray: [Int], _ tag: Int, _ subAns: inout [Int], _ ans: inout [[Int]]) {
        if tag == countArray.count {
            ans.append(subAns)
            return
        }
        subSets(countArray, tag + 1, &subAns, &ans)
        for _ in 0..<countArray[tag] {
            subAns.append(tag - 10)
            subSets(countArray, tag + 1, &subAns, &ans)
        }
        for _ in 0..<countArray[tag] {
            subAns.removeLast()
        }
    }
    func trap(_ height: [Int]) -> Int {
        var heightIndexStack = [Int]()
        var ans = 0
        for (index, data) in height.enumerated() {
            while !heightIndexStack.isEmpty && data > height[heightIndexStack.last!] {
                let nowHeightIndex =  heightIndexStack.removeLast()
                if heightIndexStack.isEmpty {
                    break
                }
                let leftHeightIndex = heightIndexStack.last!
                let curHeight = min(height[leftHeightIndex], data) - height[nowHeightIndex]
                ans += (index - leftHeightIndex - 1) * curHeight
            }
            heightIndexStack.append(index)
        }
        return ans
    }
    func clumsy(_ N: Int) -> Int {
        var dataStack = [Int]()
        dataStack.append(N)
        for i in 0..<N-1 {
            let num = N - 1 - i
            let res = i % 4
            switch res {
            case 0:
                dataStack.append(dataStack.removeLast() * num)
            case 1:
                dataStack.append(dataStack.removeLast() / num)
            case 2:
                dataStack.append(num)
            default:
                dataStack.append(-num)
            }
        }
        var ans = 0
        for data in dataStack {
            ans += data
        }
        return ans
    }
}
