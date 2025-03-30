//
//  TopicsTab.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import SwiftUI
import SwiftData
import UIKit

struct TopicsTab: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var topics: [Topic]
    
    @Namespace var nameSpace
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(topics) { topic in
                    // we should pass in generated gradient colours here to both TopicView and TopicCell -> we generate gradient colour sets randomly?
                    let gradientColours = [Color.random(), Color.random()]
                    
                    NavigationLink {
                        ZStack {
                            LinearGradient(colors: gradientColours, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .ignoresSafeArea(.all, edges: .top)
                            TopicView()
                                .navigationTransition(.zoom(sourceID: "zoom", in: nameSpace))
                                .environment(topic)
                        }
                            
                    } label: {
                        TopicCell(topic: topic)
                            .background(LinearGradient(colors: gradientColours, startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .matchedTransitionSource(id: "zoom", in: nameSpace)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Topic", systemImage: "plus")
                    }
                }
            }
        }
        
    }
    
    
    private func addItem() {
        withAnimation {
            let newTopic = Topic.example
            modelContext.insert(newTopic)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(topics[index])
            }
        }
    }
}

#Preview {
    TopicsTab()
        .modelContainer(for: Topic.self, inMemory: true)
}
