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
    
    static let example = Topic(name: "Football", cards: [Card.example], dataPoints: [TopicDataPoint.example])
}
