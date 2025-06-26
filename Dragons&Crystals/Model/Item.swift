import Foundation

protocol Item: AnyObject {
    var name: String { get }
    var description: String { get }
    func canBePickedUp() -> Bool
    func use(in game: GameState, by playeer: Player) -> Bool
}

extension Item {
    func canBePickedUp() -> Bool { true }
    func use(in game: GameState, by player: Player) -> Bool { false }
}

class Key: Item {
    var name: String = "Key"
    var description: String = "A shiny key"
}

class Chest: Item {
    var name: String = "Chest"
    var description: String = "Need a key to open"
    
    func canBePickedUp() -> Bool { false }
    
    func use(in game: GameState, by player: Player) -> Bool {
        if player.inventory.contains(where: { $0 is Key }) {
            game.setVictory()
            return true
        }
        return false
    }
}

class Torch: Item {
    var name: String = "Torch"
    var description: String = "To light the room"
    
    func use(in game: GameState, by playeer: Player) -> Bool {
        return true
    }
}

class Food: Item {
    var name: String = "Food"
    var description: String = "You can eat it!"
    
    func use(in game: GameState, by playeer: Player) -> Bool {
        return true
    }
}

class Gold: Item {
    var name: String = "Gold"
    var description: String {
        return "\(amount)  coins"
    }
    let amount: Int
    
    init(amount: Int) {
        self.amount = amount
    }
    
}
