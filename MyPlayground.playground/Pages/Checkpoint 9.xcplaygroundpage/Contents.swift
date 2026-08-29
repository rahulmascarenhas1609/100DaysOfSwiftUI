import Cocoa

func optionalIntegerArray(input: [Int]?) -> Int? {
    return input?.randomElement() ?? Int.random(in: 0...100)
}
let val : [Int]? = nil
let answer = optionalIntegerArray(input: val)
print(answer)
