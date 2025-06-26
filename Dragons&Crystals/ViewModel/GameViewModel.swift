

import Foundation

class GameViewModel {
    
    // MARK: - Properties
    private var maze: Maze
    private let player: Player
    let gameState: GameState

    var messagesToDisplay: [String] = []
    var roomDescription: String = ""

    // MARK: - Init
    init(width: Int, height: Int, gameState: GameState) {
        self.maze = Maze(width: width, height: height)
        self.player = Player(position: (0, 0))
        self.gameState = gameState
    }

    func startGame(sizeInput: String) {
        let parts = sizeInput.split(separator: " ").map { String($0) }
        if parts.count == 2, let width = Int(parts[0]), let height = Int(parts[1]) {
            self.maze = Maze(width: width, height: height)
            self.player.position = (0, 0)
            self.runGameLoop()
        } else {
            messagesToDisplay.append("Invalid input. Try again (example: 5 5).".red)
        }
    }
    
    
    func runGameLoop() {
        guard !gameState.isGameOver else {
            messagesToDisplay.append(gameState.isVictory ? "You won! The grail is yours!".green : "Game over! You starved!".red)
            return
        }

        player.stepsLimit -= 1
        if player.stepsLimit <= 0 {
            gameState.setGameOver()
            runGameLoop()
            return
        }

        let currentRoom = maze.room(at: player.position)
        roomDescription = RoomFormatter.description(for: currentRoom, player: player)
        
    }

    func handleInput(_ command: String) {
        processCommand(command)
        runGameLoop()
    }
    
    // MARK: - Обработка команд
    private func processCommand(_ command: String) {
        let parts = command.lowercased().split(separator: " ").map { String($0) }
        guard !parts.isEmpty else { return }

        let currentRoom = maze.room(at: player.position)
        

        switch parts[0] {
        case "n", "s", "w", "e":
            if let direction = Direction(rawValue: parts[0].uppercased()) {
                movePlayer(direction: direction)
                if !currentRoom.isDark && currentRoom.isLighted {
                    currentRoom.isDark = true
                }
            }
        case "get":
            if parts.count > 1 {
                if let index = currentRoom.items.firstIndex(where: { $0.name.lowercased() == parts[1].lowercased() }) {
                    let item = currentRoom.items[index]

                    if item is Torch && currentRoom.isPermanentlyLit {
                        currentRoom.isPermanentlyLit = false
                        currentRoom.isDark = true
                    }
                    
                    if let gold = item as? Gold {
                        player.gold += gold.amount
                        currentRoom.items.remove(at: index)
                        messagesToDisplay.append("You picked up \(gold.amount) coins! Total gold: \(player.gold)".yellow)
                        return
                    }

                    if item.canBePickedUp() {
                        player.inventory.append(item)
                        currentRoom.items.remove(at: index)
                        messagesToDisplay.append("Picked up: \(item.name)".cyan)
                    } else {
                        messagesToDisplay.append("You can't pick up \(item.name)".red)
                    }
                }
            }
        case "drop":
            if parts.count > 1, let item = player.inventory.first(where: { $0.name.lowercased() == parts[1].lowercased() }) {
                if item is Torch {
                    currentRoom.isPermanentlyLit = true
                    currentRoom.isDark = false
                    messagesToDisplay.append("You drop the torch, and it lights up the room permanently!".yellow)
                }
                currentRoom.items.append(item)
                player.inventory.removeAll { $0 === item }
                messagesToDisplay.append("Dropped: \(item.description)".red)
            }
        case "open":
            if parts.count > 1, let item = currentRoom.items.first(where: { $0.name.lowercased() == parts[1].lowercased() }) {
                if item.use(in: gameState, by: player) {
                    messagesToDisplay.append("Opened \(item.name)! You found the grail!".yellow)
                } else {
                    messagesToDisplay.append("You cannot open \(item.name)".red)
                }
            }
        case "use":
            if parts.count > 1, let item = player.inventory.first(where: { $0.name.lowercased() == parts[1].lowercased() }) {
                if item.use(in: gameState, by: player) {
                    if item is Torch {
                        currentRoom.isDark = false
                        currentRoom.isLighted = true
                        messagesToDisplay.append("The room is light now!".yellow)
                    } else {
                        messagesToDisplay.append("Used \(item.name)".yellow)
                    }
                } else {
                    messagesToDisplay.append("You cannot use \(item.name)".red)
                }
            }
        case "eat":
            if parts.count > 1, let item = player.inventory.first(where: { $0.name.lowercased() == parts[1].lowercased() }) {
                if item.use(in: gameState, by: player) {
                    player.stepsLimit += 10
                    player.inventory.removeAll { $0 === item }
                    messagesToDisplay.append("It was delicious! Your steps limit increased!".magenta)
                }
            }
        default:
            messagesToDisplay.append("Unknown command.".red)
        }
    }

    // MARK: - Обработка движения персонажа
    private func movePlayer(direction: Direction) {
        let currentRoom = maze.room(at: player.position)
        guard currentRoom.doors.contains(direction) else {
            messagesToDisplay.append("No door in that direction".red)
            return
        }

        player.previousPosition = player.position
        switch direction {
        case .north: player.position.y -= 1
        case .south: player.position.y += 1
        case .east:  player.position.x += 1
        case .west:  player.position.x -= 1
        }

        if player.position.x < 0 || player.position.x >= maze.width ||
            player.position.y < 0 || player.position.y >= maze.height {
            messagesToDisplay.append("Cannot move outside the maze".red)
            player.position = player.previousPosition!
        }
    }
    
    
}




