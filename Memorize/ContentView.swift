//
//  ContentView.swift
//  Memorize
//
//  Created by Galina Klinskikh on 20/6/25.
//

import SwiftUI

let themeImages: [String: String] = [
    "Halloween": "🎃",
    "Transport": "🚗",
    "Sport": "🎾"
]

struct ContentView: View {
    let themes: [String: [String]] = [
        "Halloween" : ["👻", "😈", "🎃", "☠️", "👽", "💀", "🧛‍♂️", "💩"],
        "Transport" : ["🚗", "🚜", "🚲", "🚑", "🚔", "🎡", "🛴", "🛞"],
        "Sport": ["🏀", "🎾", "⚽️", "🏓", "🥅", "🛼", "⛸️", "🏹"]
    ]
    @State var currentTheme: String = "Halloween"
    //@State var cardCount: Int = 16
    let numberOfPairs: Int = 8
    
    //8 пар всего 16 карточек
    @State private var pairedEmojis: [String] = []
    
    func generatedPairs(for theme: String) -> [String] {
        let emojis = themes[currentTheme] ?? []
        let selected = Array(emojis.shuffled().prefix(numberOfPairs))
        let pairs = Array(selected) + Array(selected)
        return pairs.shuffled()
    }
    
    init() {
        _pairedEmojis = State(initialValue: [])
    }
    
//    var emojis: [String] {
//        themes[currentTheme] ?? []
//    }
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
            
//            ScrollView {
//                cards
//            }
        Spacer()
            themeButtons
        }
        .padding()
    }
    
//    var cardCoundAdjusters: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
    
//    var cards: some View {
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
//            ForEach(0..<cardCount, id: \.self) { index in
//                CardView(content: pairedEmojis[index])
//                    .aspectRatio(2/3, contentMode: .fit)
//            }
//        }
//        .foregroundColor(.orange)
//    }
    
    //кнопка выбора темы
    var themeButtons: some View {
        HStack {
            ForEach(Array(themes.keys), id: \.self) { theme in
                let isSelected = currentTheme == theme
                let bgColor = isSelected ? Color.orange : Color.gray.opacity(0.2)
                let fgColor: Color = isSelected ? .white : .black
                
                Button(action: {
                    currentTheme = theme
                    pairedEmojis = generatedPairs(for: theme)
                }) {
                    VStack(spacing:4) {
                        Text(themeImages[theme] ?? "")
                            .font(.largeTitle)
                    Text(theme)
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
    
//    func cardCountAdjuster(by offcet: Int, symbol: String) -> some View {
//        Button(action: {
//                cardCount += offcet
//            }, label:{
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offcet < 1 || cardCount + offcet > emojis.count)
//    }
//    
//    var cardRemover: some View {
//        return cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
//    }
//    
//    var cardAdder: some View {
//        return cardCountAdjuster(by: +1, symbol: "plus.circle.fill")
//    }
    
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
