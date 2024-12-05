//
//  Answer.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/12/4.
//

import Foundation

// Answer model, conforms to Codable and Decodable protocols for Firebase interaction
struct Answer: Codable {
    var questionID: String
    var answerText: String? // Changed to an optional type String?
    var isCompleted: Bool
    var timestamp: Date

    // Default initializer
    init(questionID: String, answerText: String? = nil, isCompleted: Bool, timestamp: Date) {
        self.questionID = questionID
        self.answerText = answerText
        self.isCompleted = isCompleted
        self.timestamp = timestamp
    }

    // Initialize from a dictionary
    init(from data: [String: Any]) {
        self.questionID = data["questionID"] as? String ?? ""
        self.answerText = data["answerText"] as? String // No default value provided here
        self.isCompleted = data["isCompleted"] as? Bool ?? false
        self.timestamp = data["timestamp"] as? Date ?? Date()
    }

    // Convert model data to dictionary to save in Firebase
    func toDictionary() -> [String: Any] {
        return [
            "questionID": questionID,
            "answerText": answerText ?? "", // If answerText is nil, use an empty string
            "isCompleted": isCompleted,
            "timestamp": timestamp
        ]
    }
}
