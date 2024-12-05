//
//  User.swift
//  
//
//  Created by yan ran on 2024/11/28.
//

import Foundation
import FirebaseFirestore

// User model, conforms to Codable protocol for Firebase interaction
struct User: Codable {
    @DocumentID var userID: String? // Automatically generated Firebase document ID
    var userName: String
    var profilePicURL: String? // Firebase Storage URL for the user's profile picture
    var email: String
    var score: Int
    var answers: [String: Answer] // [QuestionID: Answer] mapping
    var solvedQuestions: [Answer] // List of Answer objects for solved questions
    var comments: [String] // List of CommentIDs

    // Default initializer
    init(
        userID: String? = nil,
        userName: String,
        profilePicURL: String? = nil,
        email: String,
        score: Int = 0,
        answers: [String: Answer] = [:],
        solvedQuestions: [Answer] = [],
        comments: [String] = []
    ) {
        self.userID = userID
        self.userName = userName
        self.profilePicURL = profilePicURL
        self.email = email
        self.score = score
        self.answers = answers
        self.solvedQuestions = solvedQuestions
        self.comments = comments
    }

    // Initialize from Firebase data
    init(from data: [String: Any]) {
        self.userID = data["userID"] as? String
        self.userName = data["userName"] as? String ?? ""
        self.profilePicURL = data["profilePicURL"] as? String
        self.email = data["email"] as? String ?? ""
        self.score = data["score"] as? Int ?? 0
        
        // Convert answers and solvedQuestions to the corresponding types
        if let answerDict = data["answers"] as? [String: [String: Any]] {
            self.answers = answerDict.compactMapValues { Answer(from: $0) }
        } else {
            self.answers = [:]
        }
        
        if let solvedQuestionData = data["solvedQuestions"] as? [[String: Any]] {
            self.solvedQuestions = solvedQuestionData.compactMap { Answer(from: $0) }
        } else {
            self.solvedQuestions = []
        }
        
        self.comments = data["comments"] as? [String] ?? []
    }

    // Convert model data to dictionary for Firebase storage
    func toDictionary() -> [String: Any] {
        return [
            "userID": userID ?? "",
            "userName": userName,
            "profilePicURL": profilePicURL ?? "",
            "email": email,
            "score": score,
            "answers": answers.mapValues { $0.toDictionary() }, // Convert Answer objects to dictionary
            "solvedQuestions": solvedQuestions.map { $0.toDictionary() }, // Convert Answer objects to dictionary
            "comments": comments
        ]
    }
}
