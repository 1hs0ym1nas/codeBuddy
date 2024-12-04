//
//  Comment.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/28.
//

import Foundation
import FirebaseFirestore

struct Comment: Codable {
    @DocumentID var commentID: String? // Firestore 自动管理
    var text: String
    var userID: String
    var userName: String
    var timestamp: Date

    // 初始化方法（手动创建时）
    init(commentID: String? = nil, text: String, userID: String, userName: String, timestamp: Date = Date()) {
        self.commentID = commentID
        self.text = text
        self.userID = userID
        self.userName = userName
        self.timestamp = timestamp
    }

    // 从 Firebase 数据中初始化
    init(from data: [String: Any]) {
        self.commentID = data["commentID"] as? String
        self.text = data["text"] as? String ?? ""
        self.userID = data["userID"] as? String ?? ""
        self.userName = data["userName"] as? String ?? ""
        self.timestamp = (data["timestamp"] as? Timestamp)?.dateValue() ?? Date()
    }

    // 转换为字典（用于保存到 Firestore）
    func toDictionary() -> [String: Any] {
        return [
            "text": text,
            "userID": userID,
            "userName": userName,
            "timestamp": Timestamp(date: timestamp)
        ]
    }
}
