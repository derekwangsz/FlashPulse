//
//  TopicCellView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import SwiftUI

struct TopicCell: View {
    
    var topic: Topic
    
    var body: some View {
        ZStack {
            Text(topic.name)
                .foregroundStyle(.black)
                .font(.title)
                .bold()
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.horizontal)
        .shadow(radius: 6, x: 6, y: 8)
        .padding(.vertical)
    }
}

#Preview {
    TopicCell(topic: Topic.example)
}
