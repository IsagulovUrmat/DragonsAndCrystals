
import Foundation

// MARK: - Структура для показа основной информации о комнате
struct RoomFormatter {
    static func description(for room: Room, player: Player) -> String {
        
        let isRoomVisible = !room.isDark || room.isPermanentlyLit
        
        guard isRoomVisible else {
            return darkRoomDescription()
        }
        
        let doors = room.doors.map { $0.rawValue }.joined(separator: ", ")
        let items = room.items.map { "\($0.name.lowercased().green) (\($0.description.cyan))" }.joined(separator: ", ")
        let inventory = player.inventory.map { $0.name }.joined(separator: ", ")
        
        return """
        You are in the room [\(room.coordinate.x), \(room.coordinate.y)].
        There are \(room.doors.count) doors: \(doors.red).
        Items in the room: \(items.isEmpty ? "none" : items).
        Player inventory: \(inventory.isEmpty ? "empty".blue : inventory).
        """.yellow
    }
    
    static func darkRoomDescription() -> String {
        return "Can't see anything in this dark place!".red
    }
}
