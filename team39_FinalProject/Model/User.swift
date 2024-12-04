//
//  User.swift
//  
//
//  Created by yan ran on 2024/11/28.
//

import Foundation
import FirebaseFirestore

// User 模型，符合 Codable 协议以支持 Firebase 交互
struct User: Codable {
    @DocumentID var userID: String? // Firebase 自动生成的文档 ID
    var userName: String
    var profilePicURL: String? // 存储头像的 Firebase Storage URL
    var email: String
    var score: Int
    var answers: [String: String] // [QuestionID: Answer]
    var solvedQuestions: [String] // List of QuestionIDs
    var comments: [String] // List of CommentIDs

    // 默认初始化器
    init(
        userID: String? = nil,
        userName: String,
        profilePicURL: String? = nil,
        email: String,
        score: Int = 0,
        answers: [String: String] = [:],
        solvedQuestions: [String] = [],
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

    // 从 Firebase 数据中初始化
    init(from data: [String: Any]) {
        self.userID = data["userID"] as? String
        self.userName = data["userName"] as? String ?? ""
        self.profilePicURL = data["profilePicURL"] as? String
        self.email = data["email"] as? String ?? ""
        self.score = data["score"] as? Int ?? 0
        self.answers = data["answers"] as? [String: String] ?? [:]
        self.solvedQuestions = data["solvedQuestions"] as? [String] ?? []
        self.comments = data["comments"] as? [String] ?? []
    }

    // 将模型数据转化为字典以保存到 Firebase
    func toDictionary() -> [String: Any] {
        return [
            "userID": userID ?? "",
            "userName": userName,
            "profilePicURL": profilePicURL ?? "",
            "email": email,
            "score": score,
            "answers": answers,
            "solvedQuestions": solvedQuestions,
            "comments": comments
        ]
    }
}
