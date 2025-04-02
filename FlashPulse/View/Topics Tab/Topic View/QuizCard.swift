//
//  QuizCardView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-04-02.
//

import SwiftUI

struct QuizCard: View {
    
    let card: Card
    
    @State private var isShowingAnswer = false
    
    @State private var isShowingHint = false
    @State private var isShowingHintImage = false
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .opacity(0.3)
            
            VStack {
                // card
                VStack {
                    Text(card.prompt)
                    
                    if isShowingHintImage {
                        card.hintImage!
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                    if isShowingHint {
                        Text(card.hint)
                    }
                    
                }
                
                // buttons
                VStack {
                    if card.hintImage != nil && !isShowingHintImage {
                        Button("Show hint image") {
                            isShowingHintImage = true
                        }
                    }
                    
                    if card.hintAvailable && !isShowingHint {
                        Button("Show hint") {
                            isShowingHint = true
                        }
                    }
                    
                    
                    if !isShowingAnswer {
                        Button("SHOW ANSWER") {
                            isShowingAnswer = true
                        }
                        .padding(.top)
                    }
                    
                }
                
                // ANSWER TEXT
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.headline)
                        .padding(.top)
                }
                    
            }
        }
    }
}

#Preview {
    QuizCard(card: Card.example)
}
