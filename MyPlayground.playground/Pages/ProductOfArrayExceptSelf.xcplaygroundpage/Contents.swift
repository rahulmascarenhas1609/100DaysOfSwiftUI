//: [Previous](@previous)

import Foundation

func productExceptSelf(_ nums: [Int]) -> [Int] {
    var result : [Int] = []
    var product = 1
    var index = 0
    
    while index < nums.count {
        for value in 0..<nums.count {
            if value != index {
                product *= nums[value]
            }
        }
        result.append(product)
        product = 1
        index += 1
    }
    
    return result
}

func productSelfWithoutDiv(_ nums: [Int]) -> [Int] {
    var result : [Int] = []
    var before = 1
    var index = 0
    
    while index < nums.count - 1 {
        result[index] = before
        before = before * nums[index]
        index += 1
    }
    
    return [0]
}

print(productSelfWithoutDiv([1,2,4,6]))
