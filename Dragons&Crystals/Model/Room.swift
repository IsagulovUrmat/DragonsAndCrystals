import Foundation

enum Direction: String {
    case north = "N", south = "S", east = "E", west = "W"
}

class Room {
    let coordinate: (x: Int, y: Int)
    var doors: [Direction]
    var items: [Item]
    var isDark: Bool
    var isPermanentlyLit: Bool = false
    var isLighted: Bool = false
    var monster: Monster?
    
    init(coordinate: (x: Int, y: Int), doors: [Direction] = [], items: [Item] = [], isDark: Bool = false) {
        self.coordinate = coordinate
        self.doors = doors
        self.items = items
        self.isDark = isDark
    }
}
