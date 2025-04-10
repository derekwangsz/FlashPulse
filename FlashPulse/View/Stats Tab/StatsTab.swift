//
//  StatsTab.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import SwiftUI
import SwiftData
import Charts


struct StatsTab: View {
    
    @Query private var topics: [Topic]
    
    var body: some View {
        
        if topics.isEmpty {
            Text("No Stats available,\nget some quizzes done to see your stats!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
        } else {
            // show each topic
            ScrollView {
                ForEach(topics, id: \.self) { topic in
                    VStack {
                        Text(topic.name)
                            .font(.headline)
                        Chart(topic.dataPoints) { dataPoint in
                            LineMark(x: .value("Attempt", dataPoint.attempt),
                                     y: .value("Score", dataPoint.accuracyPercentage))
                            .shadow(radius: 3, x: 2, y: 7)
                        }
                        .aspectRatio(2, contentMode: .fit)
                        .chartYAxisLabel("Accuracy (%)")
                        .chartYScale(domain: 0...100)
                        .chartXAxisLabel("Attempt")
                        .chartXScale(domain: 1...(topic.dataPoints.last?.attempt ?? 1))
                        .chartXAxis {
                            AxisMarks(values: .stride(by: 1)) { value in
                                AxisValueLabel()
                                AxisGridLine()
                                AxisTick()
                            }
                        }
                    }
                    .padding()
                    .border(.gray)
                }
            }
        }
    }
}

#Preview {
    StatsTab()
        .modelContainer(Topic.previewContainer)
}
