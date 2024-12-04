import UIKit
import Firebase

class AnswerViewController: UIViewController {
    private let answerView = AnswerView()
    private let questionID: String
    private let leetcodeLink: String
    private var user: User
    private var remainingTime: Int
    private let titleSlug: String
    private var timer: Timer?

    init(questionID: String, leetcodeLink: String, user: User, remainingTime: Int, titleSlug: String) {
        self.questionID = questionID
        self.leetcodeLink = leetcodeLink
        self.user = user
        self.remainingTime = remainingTime
        self.titleSlug = titleSlug
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = answerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        answerView.markCompletedButton.addTarget(self, action: #selector(didTapMarkCompleted), for: .touchUpInside)


        answerView.updateTitle(formatTitleSlug(titleSlug))
        startCountdown()
        loadPreviousAnswer()
        loadSolvedQuestions()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startCountdown()
    }

    private func formatTitleSlug(_ slug: String) -> String {
        return slug.split(separator: "-").map { $0.capitalized }.joined(separator: " ")
    }

    private func loadPreviousAnswer() {
        if let savedAnswer = user.answers[questionID] {
            answerView.textView.text = savedAnswer.answerText
        } else {
            let db = Firestore.firestore()
            db.collection("answers").document(user.userID).collection("userAnswers").document(questionID).getDocument { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching previous answer: \(error)")
                    return
                }
                guard let data = snapshot?.data(),
                      let answerText = data["answerText"] as? String,
                      let isCompleted = data["isCompleted"] as? Bool,
                      let timestamp = data["timestamp"] as? Timestamp else {
                          return
                      }

                let answer = Answer(
                    questionID: self.questionID,
                    answerText: answerText,
                    isCompleted: isCompleted,
                    timestamp: timestamp.dateValue()
                )
                self.user.answers[self.questionID] = answer
                self.answerView.textView.text = answer.answerText
            }
        }
    }


    @objc private func didTapSave() {
        saveAnswer(isCompleted: false)
    }

    @objc private func didTapMarkCompleted() {
        guard let existingAnswer = user.answers[questionID], existingAnswer.isCompleted else {
            saveAnswer(isCompleted: true)
            return
        }

        let alert = UIAlertController(title: "Already Completed", message: "This question is already marked as completed.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "View Answer on LeetCode", style: .default) { _ in
            if let url = URL(string: self.leetcodeLink) {
                UIApplication.shared.open(url)
            }
        })
        present(alert, animated: true)
    }

    private func saveAnswer(isCompleted: Bool) {
        let answerText = answerView.textView.text ?? ""
        let timestamp = Date()

        let answer = Answer(questionID: questionID, answerText: answerText, isCompleted: isCompleted, timestamp: timestamp)
        user.answers[questionID] = answer

        let db = Firestore.firestore()
        db.collection("answers").document(user.userID).collection("userAnswers").document(questionID).setData([
            "questionID": questionID,
            "answerText": answerText,
            "isCompleted": isCompleted,
            "timestamp": Timestamp(date: timestamp)
        ]) { error in
            if let error = error {
                print("Error saving to Firebase: \(error)")
            } else {
                print("Answer saved to Firebase successfully.")
                self.loadPreviousAnswer()
            }
        }

        let alertTitle = isCompleted ? "Completed" : "Saved"
        let alertMessage = isCompleted ? "This question has been marked as completed!" : "Your answer has been saved successfully!"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        if isCompleted {
            alert.addAction(UIAlertAction(title: "View Answer on LeetCode", style: .default) { _ in
                if let url = URL(string: self.leetcodeLink) {
                    UIApplication.shared.open(url)
                }
            })
        }
        else {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        present(alert, animated: true)
    }
    
    // get all completed anwsers by the user, by using user.solvedQuestions
    private func loadSolvedQuestions() {
        let db = Firestore.firestore()
        db.collection("answers")
            .document(user.userID)
            .collection("userAnswers")
            .whereField("isCompleted", isEqualTo: true)
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching completed answers: \(error)")
                    return
                }

                guard let documents = snapshot?.documents else { return }
                
                self.user.solvedQuestions = documents.compactMap { doc in
                    let data = doc.data()
                    guard let questionID = data["questionID"] as? String,
                          let answerText = data["answerText"] as? String,
                          let isCompleted = data["isCompleted"] as? Bool,
                          let timestamp = data["timestamp"] as? Timestamp else {
                              return nil
                          }
                    return Answer(
                        questionID: questionID,
                        answerText: answerText,
                        isCompleted: isCompleted,
                        timestamp: timestamp.dateValue()
                    )
                }

                print("The user solved \(self.user.solvedQuestions.count) questions.")
            }
    }

    private func startCountdown() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.updateCountdownUI()
            } else {
                self.timer?.invalidate()
                self.showTimeUpAlert()
            }
        }
    }

    private func updateCountdownUI() {
        let progress = CGFloat(remainingTime) / CGFloat(15 * 60)
        answerView.updateCountdownProgress(progress)

        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        answerView.updateCountdown(String(format: "%02d:%02d", minutes, seconds))
    }

    private func showTimeUpAlert() {
        let alert = UIAlertController(title: "Time is up!", message: "You can continue writing your answer.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
