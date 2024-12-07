import Foundation

/*
struct User {
    let userID: String
    let userName: String
    var profilePic: String?
    var email: String
    var answers: [String: Answer]
    var solvedQuestions: [Answer] 
    var score: Int {
        answers.values.filter { $0.isCompleted }.count
    }
}

extension User {
    static func mockUser() -> User {
        return User(
            userID: "mockUser123",
            userName: "Mock User",
            profilePic: nil,
            email: "mockuser@example.com",
            answers: [:], 
            solvedQuestions: []
        )
    }
}
 */

struct QuestionListItem: Codable {
    var questionFrontendId: String
    var title: String
    var titleSlug: String
    var difficulty: String
    var difficultyInfo: (starCount:Int, time: String){
        switch difficulty.lowercased(){
        case "easy":
            return (1, "30 min")
        case "medium":
            return (2, "40 min")
        case "hard":
            return (3, "50 min")
        default:
            return (0, "unknown")
        }
    }
}


struct Question: Codable {
    var questionFrontendId: String
    var title: String
    var titleSlug: String
    var description: String
    var difficulty: String
    var leetcodeLink: String
    var exampleTestcases: String
    
   
    // Custom initializer
    init(questionFrontendId: String, title: String, titleSlug: String, difficulty: String, description: String, leetcodeLink: String, exampleTestcases: String) {
        self.questionFrontendId = questionFrontendId
        self.title = title
        self.titleSlug = titleSlug
        self.difficulty = difficulty
        self.description = description
        self.leetcodeLink = leetcodeLink
        self.exampleTestcases = exampleTestcases
    }
}

struct QuestionResponse: Codable{
    let problemsetQuestionList: [QuestionListItem]
}


struct Answer: Codable {
    let questionID: String
    var answerText: String
    var isCompleted: Bool
    var timestamp: Date
}