//
//  main.swift
//  Dragons&Crystals
//
//  Created by sunflow on 24/6/25.
//

import Foundation

let gameState = GameState()
let viewModel = GameViewModel(width: 5, height: 5, gameState: gameState)
let console = ConsoleView(viewModel: viewModel)
console.run()


//dispatchMain()
