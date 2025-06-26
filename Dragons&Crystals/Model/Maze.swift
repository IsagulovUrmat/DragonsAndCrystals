import Foundation

class Maze {
    let width: Int
    let height: Int
    private var grid: [[Room]]
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.grid = (0..<height).map { y in
            (0..<width).map { x in
                Room(coordinate: (x, y))
            }
        }
        generateMaze()
        placeItems()
        placeMonsters()
    }
    
    func room(at coordinate: (x: Int, y: Int)) -> Room {
        return grid[coordinate.y][coordinate.x]
    }
    
    private func generateMaze() {
        for y in 0..<height {
            for x in 0..<width {
                var doors: [Direction] = []
                if x > 0 { doors.append(.west) }
                if x < width - 1 { doors.append(.east) }
                if y > 0 { doors.append(.north) }
                if y < height - 1 { doors.append(.south) }
                grid[y][x] = Room(coordinate: (x, y), doors: doors, isDark: false)
            }
        }
        
        let darkX = Int.random(in: 0..<width)
        let darkY = Int.random(in: 0..<height)
        grid[darkY][darkX].isDark = true
    }
    
    private func placeItems() {
        let allRooms = grid.flatMap { $0 }
        
        if let torchRoom = allRooms.filter({ !$0.isDark }).randomElement() {
            torchRoom.items.append(Torch())
        }
        
        if let keyRoom = allRooms.filter({ $0.items.isEmpty }).randomElement() {
            keyRoom.items.append(Key())
        }
        
        if let chestRoom = allRooms.filter({ $0.items.isEmpty }).randomElement() {
            chestRoom.items.append(Chest())
        }
        
        if let foodROom = allRooms.filter({ $0.items.isEmpty }).randomElement() {
            foodROom.items.append(Food())
        }
        
        let goldRooms = allRooms.shuffled().prefix(3)
        for room in goldRooms {
            let amount = Int.random(in: 50...200)
            room.items.append(Gold(amount: amount))
        }

    }
    
    private func placeMonsters() {
        let allRooms = grid.flatMap { $0 }
        let availableRooms = allRooms.filter { $0.coordinate != (0, 0) && $0.monster == nil }
        let types: [Monster] = [Voldemort(), Goblin()]
        
        for _ in 0..<2 { // допустим, 2 монстра
            if let room = availableRooms.randomElement() {
                room.monster = types.randomElement()
            }
        }
    }

}
