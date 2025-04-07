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
    @Environment(Topic.self) private var topic
    
    @State private var displayedCards: [Card] = []
    @State private var numKnown = 0
    @State private var isShowingSummaryView = false
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                ForEach(0..<displayedCards.count, id: \.self) { i in
                    QuizCard(card: displayedCards[0])
                        .offset(CGSize(width: 0, height: i * 10))
                }
            }
            
            if isShowingSummaryView {
                VStack {
                    Text("Quiz Completed!\n You knew \(numKnown)/\(topic.cards.count) cards!")
                        .bold()
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Button("OK") {
                        dismiss()
                    }
                    .buttonStyle(.myAppPrimaryButton)
                }
            }
            
            Spacer()
            
            if !displayedCards.isEmpty {
                VStack {
                    HStack {
                        
                        Button("DON'T KNOW") {
                            removeCard()
                        }
                        .buttonStyle(.myAppSecondaryButton)
                        
                        Button("KNOW") {
                            numKnown += 1
                            removeCard()
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
        .onAppear {
            displayedCards = topic.cards.shuffled()
        }
    }
    
    
    
    func removeCard() {
        withAnimation {
            displayedCards.removeFirst(1)
        }
        // if we are out of cards, save statistics and dismiss QuizView
        if displayedCards.isEmpty {
            topic.numAttempted += 1
            let dataPoint = TopicDataPoint(attempt: topic.numAttempted, accuracyPercentage: numKnown / topic.cards.count * 100)
            topic.dataPoints.append(dataPoint)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isShowingSummaryView = true
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
    QuizView()
        .environment(Topic.example)
}
