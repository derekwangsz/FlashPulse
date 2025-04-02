//
//  QuizView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-04-01.
//

import SwiftUI

struct QuizView: View {
    
    //MARK: - In the quiz view, we need to be able to show prompt, hint if there is one, hint image if there is one, and the answer when requested
    
    //MARK: - Create a TopicDataPoint and add to topic when the quiz ends
    
    @Environment(\.dismiss) private var dismiss
    
    var cards: [Card]
    @State private var displayedCards: [Card] = []
    
    
    init(cards: [Card]) {
        // initialize the state with passed in cards -> we want @State cards list just to update the view
        self.cards = cards
        _displayedCards = State(initialValue: cards)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            ForEach(0..<displayedCards.count, id: \.self) { i in
                QuizCard(card: cards[i])
                    .stacked(at: i, in: cards.count)
            }
            
            Spacer()
            
            VStack {
                HStack {
                    
                    Button("DON'T KNOW") {
                        
                    }
                    .buttonStyle(.myAppSecondaryButton)
                    
                    Button("KNOW") {
                        
                    }
                    .buttonStyle(.myAppSecondaryButton)
                }
                
                Button("Exit") {
                    dismiss()
                }
                .buttonStyle(.myAppPrimaryButton)
            }
        }
    }
}

extension View {
    
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

#Preview {
    QuizView(cards: Topic.example.cards)
}
