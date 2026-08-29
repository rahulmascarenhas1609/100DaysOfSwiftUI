//: [Previous](@previous)

import Cocoa


let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

print(luckyNumbers.filter({ $0 % 2 != 0}).sorted(by: < ).map({ "\($0) is a lucky number"}))


let answer = { (values: [Int]) in
    for num in 0..<values.count {
        print("\(values[num]) is a lucky number")
    }
}

answer(luckyNumbers.filter({ $0 % 2 != 0}).sorted(by: < ))
