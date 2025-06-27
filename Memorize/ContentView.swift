//
//  ContentView.swift
//  Memorize
//
//  Created by Galina Klinskikh on 20/6/25.
//

import SwiftUI

struct Theme {
    let symbolName: String
    let title: String
    let cardImage: [String]
}

struct ContentView: View {
    let themes: [Theme] = [
        Theme(
            symbolName: "moon.stars.fill",
            title: "Halloween",
            cardImage: ["👻", "😈", "🎃", "☠️", "👽", "💀", "🧛‍♂️", "💩"]
        ),
        Theme(
            symbolName: "car.fill",
            title: "Transport",
            cardImage: ["🚗", "🚜", "🚲", "🚑", "🚔", "🎡", "🛴", "🛞"]
        ),
        Theme(
            symbolName: "tennisball.fill",
            title: "Sport",
            cardImage: ["🏀", "🎾", "⚽️", "🏓", "🥅", "🛼", "⛸️", "🏹"])
        
    ]
    
    
//    [String: [String]] = [
//        "Halloween" : ["👻", "😈", "🎃", "☠️", "👽", "💀", "🧛‍♂️", "💩"],
//        "Transport" : ["🚗", "🚜", "🚲", "🚑", "🚔", "🎡", "🛴", "🛞"],
//        "Sport": ["🏀", "🎾", "⚽️", "🏓", "🥅", "🛼", "⛸️", "🏹"]
//    ]
    
    @State var currentTheme: String = "Halloween"
    //@State var cardCount: Int = 16
    let numberOfPairs: Int = 8
    
    //8 пар всего 16 карточек
    @State private var pairedEmojis: [String] = []
    
    func generatedPairs(for themeTitle: String) -> [String] {
        guard let theme = themes.first(where: { $0.title == themeTitle }) else {return []}
        let emojis = theme.cardImage
        let selected = Array(emojis.shuffled().prefix(numberOfPairs))
        let pairs = selected + selected
        return pairs.shuffled()
    }
    
    init() {
        _pairedEmojis = State(initialValue: [])
    }
    
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            GeometryReader { geometry in
                let spacing: CGFloat = 8
                let columns = 4
                let totalSpacing = spacing * CGFloat(columns + 1)
                let cardWidth = (geometry.size.width - totalSpacing) / CGFloat(columns)
                let cardHeight = cardWidth * 1.4
                
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(cardWidth), spacing: spacing), count: columns),
                    spacing: spacing
                ) {
                    ForEach(0..<pairedEmojis.count, id: \.self) {
                        index in
                        CardView(content: pairedEmojis[index])
                            .frame(width: cardWidth, height: cardHeight)
                    }
                }
                .padding(.horizontal, spacing)
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(.bottom)
            

        Spacer()
            themeButtons
        }
        .padding()
    }
    

    
    //кнопка выбора темы
    var themeButtons: some View {
        HStack {
            ForEach(themes, id: \.title) { theme in
                let isSelected = currentTheme == theme.title
                let bgColor = isSelected ? Color.orange : Color.gray.opacity(0.2)
                let fgColor: Color = isSelected ? .white : .black
                
                Button(action: {
                    currentTheme = theme.title
                    pairedEmojis = generatedPairs(for: theme.title)
                }) {
                    VStack(spacing:4) {
                        Image(systemName: theme.symbolName)
                            .font(.largeTitle)
                        Text(theme.title)
                            .padding(8)
                            .background(bgColor)
                            .foregroundColor(fgColor)
                            .cornerRadius(8)
                    }
                    
                }
            }
        }
        .onAppear {
            pairedEmojis = generatedPairs(for: currentTheme)
        }
        .padding(.horizontal)
    }
    
    //карточка
    struct CardView: View {
        var content: String
        @State var isFaceUp: Bool = false
        var body: some View {
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceUp ? 1 : 0)
                base.fill(.orange).opacity(isFaceUp ? 0 : 1)
            }
            .onTapGesture {
            isFaceUp.toggle()
            }
        }
    }
}


#Preview {
    ContentView()
}
