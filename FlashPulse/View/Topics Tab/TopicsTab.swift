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
    
    //MARK: - Add swipe to delete functionality from iJournal -> with confirmation dialog because it's a quite big operation
    
    @Environment(\.modelContext) private var modelContext
    @Query private var topics: [Topic]
    
    @Namespace var nameSpace
    
    @State private var showAddTopicSheet: Bool = false
    @State private var newTopicTitle: String = ""
    
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
                    Button {
                        showAddTopicSheet = true
                    } label:{
                        Label("Add Topic", systemImage: "plus")
                    }
                }
            }
            .alert("Enter Topic Name", isPresented: $showAddTopicSheet) {
                TextField("Topic name", text: $newTopicTitle)
                Button("Cancel", role: .cancel) { }
                Button("OK") {
                    withAnimation {
                        modelContext.insert(Topic(name: newTopicTitle, cards: [], dataPoints: []))
                    }
                    newTopicTitle = ""
                }
            }
        }
        
    }
}

#Preview {
    TopicsTab()
        .modelContainer(for: Topic.self, inMemory: true)
}
