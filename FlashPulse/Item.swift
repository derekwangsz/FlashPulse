//
//  Item.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
