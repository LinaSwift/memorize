//
//  ContentView.swift
//  Memorize
//
//  Created by Galina Klinskikh on 20/6/25.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "😈", "🎃", "☠️"]
    @State var cardCount: Int = 4
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCoundAdjusters
        }
        .padding()
    }
    
    var cardCoundAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offcet: Int, symbol: String) -> some View {
        Button(action: {
                cardCount += offcet
            }, label:{
            Image(systemName: symbol)
        })
        .disabled(cardCount + offcet < 1 || cardCount + offcet > emojis.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "plus.circle.fill")
    }
    
    
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
                base.fill().opacity(isFaceUp ? 0 : 1)
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
