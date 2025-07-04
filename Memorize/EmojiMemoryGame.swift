



import SwiftUI

class EmojiMemoryGame: ObservableObject {
     private static let emojis = ["👻", "😈", "🎃", "☠️", "👽", "💀", "🧛‍♂️", "💩"]
    
       
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 6)  { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "🚫"
            }
            //return emojis [pairIndex]
        }
    }
    
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intentes
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    
    
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
    

