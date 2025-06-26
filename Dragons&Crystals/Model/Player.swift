import Foundation

class Player {
    var position: (x: Int, y: Int)
    var previousPosition: (x: Int, y: Int)?
    var inventory: [Item]
    var stepsLimit: Int
    var hasTorch: Bool = false
    var gold: Int = 0

    init(position: (x: Int, y: Int), stepsLimit: Int = 50) {
        self.position = position
        self.inventory = []
        self.stepsLimit = stepsLimit
    }
    
   
}
