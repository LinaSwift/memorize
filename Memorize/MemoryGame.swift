import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card)
    
    struct Card {
        var isFaceUp: Bool
        var isMached: Bool
        var content: CardContent
    }
}
