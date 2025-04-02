//
//  CardView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-04-01.
//

import SwiftUI

struct TopicCard: View {
    
    let card: Card
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(card.prompt)
                    .font(.headline)
                Text(card.answer)
                    .font(.caption)
            }
            Spacer()
        }
    }
}

#Preview {
    TopicCard(card: Card.example)
}
