//
//  AddTopicSheet.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-04-10.
//

import SwiftUI

struct AddTopicSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var isPresented: Bool
    
    @State private var topicTitle = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Topic name", text: $topicTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isTextFieldFocused)
                    .padding()
            }
            .navigationTitle("Add New Topic")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !topicTitle.isEmpty {
                            withAnimation {
                                modelContext.insert(Topic(name: topicTitle, cards: [], dataPoints: []))
                            }
                            isPresented = false
                        }
                    }
                    .disabled(topicTitle.isEmpty)
                }
            }
            .onAppear {
                isTextFieldFocused = true
            }
        }
    }
}

#Preview {
    AddTopicSheet(isPresented: .constant(true))
}
