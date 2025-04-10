//
//  TopicCellView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import SwiftUI

struct TopicCell: View {
    
    @Environment(\.modelContext) var modelContext
    @Bindable var topic: Topic
    
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
        .swipeButtons([
            CustomSwipeButton(image: Image(systemName: "trash.fill"), title: "Delete", color: .red, action: {
                delete()
            })
        ])
    }
    
    func delete() {
        withAnimation {
            modelContext.delete(topic)
        }
    }
}

#Preview {
    TopicCell(topic: Topic.example)
}
