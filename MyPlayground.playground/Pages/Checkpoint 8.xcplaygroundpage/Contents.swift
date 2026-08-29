import Cocoa

/*
 Your challenge is this: make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:

 A property storing how many rooms it has.
 A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
 A property storing the name of the estate agent responsible for selling the building.
 A method for printing the sales summary of the building, describing what it is along with its other properties.
 */

protocol Building {
    var numberOfRooms: Int { get set }
    var cost: Int { get set }
    var nameOfAgent: String { get set }
    func printSalesSummary()
}

struct House: Building {
    var numberOfRooms: Int
    var cost: Int
    var nameOfAgent: String
    
    init(numberOfRooms: Int, cost: Int, nameOfAgent: String) {
        self.numberOfRooms = numberOfRooms
        self.cost = cost
        self.nameOfAgent = nameOfAgent
    }
    
    func printSalesSummary() {
        print("The number of rooms in the build are \(numberOfRooms) and the cost is \(cost). \(nameOfAgent) is the agent selling this property")
    }
}

struct Office: Building {
    var numberOfRooms: Int
    var cost: Int
    var nameOfAgent: String
    
    init(numberOfRooms: Int, cost: Int, nameOfAgent: String) {
        self.numberOfRooms = numberOfRooms
        self.cost = cost
        self.nameOfAgent = nameOfAgent
    }
    
    func printSalesSummary() {
        print("The number of rooms in the office are \(numberOfRooms) and the cost is \(cost). \(nameOfAgent) is the agent selling this property")
    }
}

var houseName = House(numberOfRooms: 4, cost: 50000, nameOfAgent: "John")
houseName.printSalesSummary()

