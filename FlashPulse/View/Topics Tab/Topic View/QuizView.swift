//
//  QuizView.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-04-01.
//

import SwiftUI

struct QuizView: View {
    
    //MARK: - In the quiz view, we need to be able to show prompt, hint if there is one, hint image if there is one, and the answer when requested
    
    @Environment(\.dismiss) private var dismiss
    
    let topic: Topic
    
    var body: some View {
        VStack {
            Text("Quiz Mode")
            Button("Exit") {
                dismiss()
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
    QuizView(topic: Topic.example)
}
