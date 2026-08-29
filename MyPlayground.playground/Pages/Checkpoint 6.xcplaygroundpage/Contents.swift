import Cocoa

struct Car {
    let model: String
    let noOfSeats: Int
    private var currentGear: Int
    
    init(model: String, noOfSeats: Int, currentGear: Int) {
        self.model = model
        self.noOfSeats = noOfSeats
        self.currentGear = currentGear
    }
    
    mutating func changeOfGear(num: Int) {
        if num == 0 {
            print("Wrong gear")
        } else if num != currentGear && num <= 6 {
            currentGear = num
            print("Gear change to \(currentGear)")
        } else if num == currentGear {
            print("No change, same gear.")
        } else if num > 6 {
            print("Last gear, cant upshift.")
        }
    }
}

var road = Car(model: "Porsche", noOfSeats: 4, currentGear: 4)
road.changeOfGear(num: 3)
road.changeOfGear(num: 7)
road.changeOfGear(num: 0)
road.changeOfGear(num: 5)
road.changeOfGear(num: 5)

