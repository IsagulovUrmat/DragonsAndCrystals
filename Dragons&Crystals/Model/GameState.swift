import Foundation

class GameState {
    var isGameOver: Bool = false
    var isVictory: Bool = false
    
    func setVictory() {
        isGameOver = true
        isVictory = true
    }
    
    func setGameOver() {
        isGameOver = true
        isVictory = false
    }
}
