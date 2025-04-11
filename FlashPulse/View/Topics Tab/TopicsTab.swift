import SwiftUI
import SwiftData
import UIKit

struct TopicsTab: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Topic.name) private var topics: [Topic]
    
    @Namespace var nameSpace
    
    @State private var showAddTopicSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(topics) { topic in
                    NavigationLink {
                        TopicView()
                            .navigationTransition(.zoom(sourceID: "zoom", in: nameSpace))
                            .environment(topic)
                    } label: {
                        TopicCell(topic: topic)
                            .background(LinearGradient(colors: topic.colours, startPoint: .topLeading, endPoint: .bottomTrailing))
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
        }
        .sheet(isPresented: $showAddTopicSheet) {
            AddTopicSheet(isPresented: $showAddTopicSheet)
                .presentationDetents([.fraction(0.4)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    TopicsTab()
        .modelContainer(for: Topic.self, inMemory: true)
}
