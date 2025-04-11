//
//  TopicView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import SwiftUI

struct TopicView: View {
    
    //MARK: - have a button that starts the quiz
    //MARK: - record statistics and store when quiz completed -> don't count when quit midway?
    
    
    @Environment(\.dismiss) private var dismiss
    @Environment(Topic.self) var topic: Topic
    
    @State private var showAddCardSheet = false
    @State private var startQuiz = false
    
    @State private var correct = 0
    @State private var totalNuberOfCards = 0
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: topic.colours, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all, edges: .top)
            VStack {
                HStack(alignment: .bottom) {
                    addButton
                    Spacer()
                    dismissButton
                }
                Text(topic.name)
                    .foregroundStyle(.primary)
                    .font(.title)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 15)
                    .background(.thinMaterial)
                    .clipShape(Capsule())
                    .padding(.bottom, 10)
                
                List {
                    ForEach(topic.cards) { card in
                        HStack {
                            TopicCard(card: card)
                            
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.insetGrouped)
                
                Button("Start Quiz") {
                    startQuiz = true
                }
                .disabled(topic.cards.isEmpty)
                .foregroundStyle(.primary)
                .padding()
                .background(.thinMaterial)
                .clipShape(Capsule())
                .shadow(radius: 2, x: 3, y: 7)
                .padding(.top, 10)
                
            }
            .sheet(isPresented: $showAddCardSheet) {
                AddCardSheet()
            }
            .fullScreenCover(isPresented: $startQuiz) {
                QuizView()
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea(.all, edges: .top)
            .statusBarHidden()
        }
        //        .onScrollGeometryChange(for: Bool.self) { geometry in
        //            geometry.contentOffset.y < -50
        //        } action: { _, isTornOff in
        //            if isTornOff {
        //                dismiss()
        //            }
        //        }
    }
    
    
    func delete(at offsets: IndexSet) {
        withAnimation(.bouncy) {
            topic.cards.remove(atOffsets: offsets)
        }
    }
    
    
    var addButton: some View {
        Button {
            showAddCardSheet = true
        } label: {
            Image(systemName: "plus")
                .frame(width: 60, height: 60)
                .foregroundColor(Color(uiColor: .label))
                .background(.thickMaterial)
                .clipShape(Circle())
        }
        .padding([.top, .leading], 35)
    }
    
    
    var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .frame(width: 40, height: 40)
                .foregroundColor(Color(uiColor: .label))
                .background(.thickMaterial)
                .clipShape(Circle())
        }
        .padding([.top, .trailing], 35)
    }
}

#Preview {
    TopicView()
        .environment(Topic.example)
}
