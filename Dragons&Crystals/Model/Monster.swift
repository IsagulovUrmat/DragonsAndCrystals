import Foundation

protocol Monster: AnyObject {
    var name: String { get }
    var description: String { get }
    var isAlive: Bool { get }
    var damage: Double { get }
    func attack(player: Player)
}

class Voldemort: Monster {
    var isAlive: Bool = true
    var name: String = "Monster"
    var damage: Double = 0.1
    var description: String = "he who must not be named"
    
    func attack(player: Player) {
        let reduction = Int(Double(player.stepsLimit) * damage)
        player.stepsLimit -= max(1, reduction)
    }
    
}

class Goblin: Monster {
    var isAlive: Bool = true
    var name: String = "Goblin"
    var damage: Double = 0.1
    var description: String = "A sneaky little goblin"
    
    func attack(player: Player) {
        let reduction = Int(Double(player.stepsLimit) * damage)
        player.stepsLimit -= max(1, reduction)
    }
}
