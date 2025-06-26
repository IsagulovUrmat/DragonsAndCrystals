import Foundation

class ConsoleView {
    private let viewModel: GameViewModel

    // MARK: - Init
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }

    func run() {
        print("""
        Your task is to find the key and open the chest with it. 
        Pick up items using the Get [Item name] command.
        An item can be dropped or used using the drop [item name] and use [item name] commands.
        If you find food, you can use the eat [item name] command to eat it.
        Move in the direction available to you using the commands [W, E, N, S]
        """.green)
        print("Enter maze size (example: 5 5):".red)
        if let sizeInput = readLine() {
            viewModel.startGame(sizeInput: sizeInput)
            gameLoop()
        }
    }

    private func gameLoop() {
        while !viewModel.gameState.isGameOver {
            
            for message in viewModel.messagesToDisplay {
                print(message)
            }
            viewModel.messagesToDisplay.removeAll()

            print(viewModel.roomDescription)

            if let input = readLine() {
                viewModel.handleInput(input)
                print("")
            }
        }

        for message in viewModel.messagesToDisplay {
            print(message)
        }
    }
}


