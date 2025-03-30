//
//  Item.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-29.
//

import Foundation
import SwiftData
import UIKit

@Model
final class Card {
    var timestamp: Date
    var prompt: String
    var hint: String
    var hintImageData: Data?
    var answer: String
    
    var topic: Topic? // every Card belongs to a Topic
    
    init(timestamp: Date, prompt: String, hint: String, hintImageData: Data?, answer: String) {
        self.timestamp = timestamp
        self.prompt = prompt
        self.hint = hint
        self.hintImageData = hintImageData
        self.answer = answer
    }
    
    
    static let example = Card(timestamp: .now, 
                              prompt: "Who is the GOAT of football?",
                              hint: "Argentinian",
                              hintImageData: UIImage(named: "messi.jpg")!.jpegData(compressionQuality: .greatestFiniteMagnitude),
                              answer: "Lionel Messi")
}
