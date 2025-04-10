//
//  Topic.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import Foundation
import SwiftData

@Model
final class Topic {
    var name: String
    var numAttempted = 0
    @Relationship(deleteRule: .cascade, inverse: \Card.topic) var cards: [Card] = [Card]()
    // Every Topic has an array of Card objects
    
    @Relationship(deleteRule: .cascade, inverse: \TopicDataPoint.topic) var dataPoints: [TopicDataPoint] = [TopicDataPoint]()
    // Every Topic has an array of data points
    
    init(name: String, cards: [Card] = [], dataPoints: [TopicDataPoint] = []) {
        self.name = name
        self.cards = cards
        self.dataPoints = dataPoints
    }
    
    static let example = Topic(name: "Football",
                               cards: [Card.example],
                               dataPoints: [TopicDataPoint.example,
                                            TopicDataPoint(attempt: 2, accuracyPercentage: 90),
                                            TopicDataPoint(attempt: 3, accuracyPercentage: 70),
                                            TopicDataPoint(attempt: 4, accuracyPercentage: 85),
                                            TopicDataPoint(attempt: 5, accuracyPercentage: 60),
                                            TopicDataPoint(attempt: 6, accuracyPercentage: 95)])
}


//MARK: - Topic Preview Mock Data Temporary Container
extension Topic {
    // Create a static property that returns a ModelContainer
    //  for previews that get modelContext from the ENVIORNMENT
    @MainActor
    static var previewContainer: ModelContainer {
        let container = try! ModelContainer(for: Topic.self,
                                            configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(Topic.example)
        return container
    }
}
