//
//  Question.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/28.
//

import Foundation
class Question {
    var questionID: String
    var title: String
    var difficultyLevel: String
    var leetcodeLink: String
    var description: String
    var problemSet: String // ProblemSet ID

    init(questionID: String, title: String, difficultyLevel: String, leetcodeLink: String, description: String, problemSet: String) {
        self.questionID = questionID
        self.title = title
        self.difficultyLevel = difficultyLevel
        self.leetcodeLink = leetcodeLink
        self.description = description
        self.problemSet = problemSet
    }
}
