//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Galina Klinskikh on 20/6/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
