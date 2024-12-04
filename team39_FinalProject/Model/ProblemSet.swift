//
//  ProblemSet.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/28.
//

import Foundation
class ProblemSet {
    var setID: String
    var name: String
    var questions: [String] // List of QuestionIDs
    var number: Int { questions.count } // Computed property for number of questions

    init(setID: String, name: String, questions: [String]) {
        self.setID = setID
        self.name = name
        self.questions = questions
    }
}
