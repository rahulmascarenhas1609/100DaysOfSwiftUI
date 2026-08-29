import Cocoa


class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func countLegs(count: Int) {
        if count > 0 && count > 1 {
            legs = count
        }
    }
}

class Dog {
    var sound = "Bow bow bow"
    func speak() {
        print(sound)
    }
}

class Cat: Animal {
    var sound = "Meow meow meow"
    var isTame = false
    
    func speak() {
        print(sound)
    }
    
    init(legs: Int, isTame: Bool = false) {
        self.isTame = isTame
        super.init(legs: legs)
    }
}

class Corgi:Dog {
    override func speak() {
        sound = "Cute dog bark"
    }
}

class Poodle:Dog {
    override func speak() {
        sound = "Small dog bark"
    }
}

class Persian: Cat {
    override func speak() {
        print("The cat is royal. Taming maybe \(isTame). Has \(legs) legs")
    }
}

class Lion: Cat {
    override func speak() {
        print("The cat is royal. Taming maybe not \(isTame). Has \(legs) legs")
    }
}

let random = Persian(legs: 8, isTame: true)
random.speak()
let random2 = Lion(legs: 4, isTame: false)
random2.speak()
