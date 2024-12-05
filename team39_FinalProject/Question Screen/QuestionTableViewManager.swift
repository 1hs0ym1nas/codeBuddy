import Foundation
import UIKit

extension QuestionScreenViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return questionList.count
        return filteredList.count  // Use filteredList here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewQuestion, for: indexPath) as! QuestionTableViewCell
        //let question = questionList[indexPath.row]
        let question = filteredList[indexPath.row]
        cell.configure(with:question)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedQuestion = filteredList[indexPath.row]
        
        let questionVC = QuestionViewController(titleSlug: selectedQuestion.titleSlug, user: User.mockUser())
        navigationController?.pushViewController(questionVC, animated: true)
    }
}


