//
//  TopicData.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import Foundation
import SwiftData

@Model
final class TopicDataPoint {
    var attempt: Int
    var accuracyPercentage: Int
    var date: Date
    
    var topic: Topic? // every TopicDataPoint belongs to a topic
    
    init(attempt: Int, accuracyPercentage: Int, date: Date = .now) {
        self.attempt = attempt
        self.accuracyPercentage = accuracyPercentage
        self.date = date
    }
    
    static let example = TopicDataPoint(attempt: 1, accuracyPercentage: 100)
}
