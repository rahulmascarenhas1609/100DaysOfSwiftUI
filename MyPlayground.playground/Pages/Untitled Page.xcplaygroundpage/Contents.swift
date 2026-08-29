import Cocoa

enum SquareRootError: Error {
    case outOfBounds
    case noRoot
}
func findSquareRoot(_ number: Int) throws -> Int {
    var result = 0
    if number < 1 || number > 10000 {
        throw SquareRootError.outOfBounds
    }
    
    for factor in 2...number {
        result = number / factor == factor ? factor : 0
        print(result)
        
        if result != 0 {
            break
        }
    }
    
    print(result,number)
    if number != result * result {
        throw SquareRootError.noRoot
    }
    
    return result
}

do {
    let answer = try findSquareRoot(10000)
    print(answer)
} catch SquareRootError.outOfBounds {
    print("Out of bounds")
} catch SquareRootError.noRoot {
    print("No root")
}

