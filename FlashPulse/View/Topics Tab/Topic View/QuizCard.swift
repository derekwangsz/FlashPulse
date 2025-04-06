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
            //            RoundedRectangle(cornerRadius: 15, style: .continuous)
            //                .foregroundStyle(.white)
            //                .shadow(radius: 10)
            
            VStack {
                // card
                Text(card.prompt)
                    .font(.headline)
                    .padding(.bottom)
                
                // buttons
                Group {
                    if card.hintImage != nil && !isShowingHintImage {
                        Button("Show hint image") {
                            withAnimation(.bouncy) {
                                isShowingHintImage = true
                            }
                        }
                    }
                    
                    if isShowingHintImage {
                        card.hintImage!
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                    
                }
                
                Group {
                    if card.hintAvailable && !isShowingHint {
                        Button("Show hint") {
                            isShowingHint = true
                        }
                    }
                    
                    if isShowingHint {
                        Text(card.hint)
                    }
                }
                
                // ANSWER TEXT
                Group {
                    if !isShowingAnswer {
                        Button("SHOW ANSWER") {
                            isShowingAnswer = true
                            
                        }
                        .padding(.top)
                    }
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.headline)
                            .padding(.top)
                    }
                }
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 10)
        
    }
}

#Preview {
    QuizCard(card: Card.example)
}
