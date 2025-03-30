//
//  TopicView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import SwiftUI

struct TopicView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Topic.self) var topic: Topic
    
    @State private var showAddCardSheet = false
    
    var body: some View {
        VStack {
            HStack {
                addButton
                Spacer()
                dismissButton
            }
            List(topic.cards) { card in
                Text(card.prompt)
            }
        }
        .sheet(isPresented: $showAddCardSheet) {
            AddCardSheet()
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .statusBarHidden()
        .onScrollGeometryChange(for: Bool.self) { geometry in
            geometry.contentOffset.y < -50
        } action: { _, isTornOff in
            if isTornOff {
                dismiss()
            }
        }
    }
    
    
    var addButton: some View {
        Button {
            showAddCardSheet = true
        } label: {
            Image(systemName: "plus")
                .frame(width: 50, height: 50)
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
                .frame(width: 30, height: 30)
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
