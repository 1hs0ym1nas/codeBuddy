import Foundation
import UIKit
import FirebaseAuth

extension QuestionScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Configs.tableViewQuestion, for: indexPath) as! QuestionTableViewCell
        let question = filteredList[indexPath.row]
        cell.configure(with: question)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedQuestion = filteredList[indexPath.row]
        
       
        if let currentUser = Auth.auth().currentUser {
            
            let user = User(userID: currentUser.uid, userName: currentUser.displayName ?? "Unknown User", email: currentUser.email ?? "")
            
            
            let questionVC = QuestionViewController(titleSlug: selectedQuestion.titleSlug, user: user)
            navigationController?.pushViewController(questionVC, animated: true)
        } else {
            
            print("No user is logged in.")
            showLoginAlert()
        }
    }

    
    private func showLoginAlert() {
        let alert = UIAlertController(title: "Not Logged In", message: "Please log in to view the question.", preferredStyle: .alert)
        let loginAction = UIAlertAction(title: "Log In", style: .default) { _ in
            
            self.redirectToLogin()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    
    private func redirectToLogin() {
        let loginViewController = LoginViewController() // 假设这是你的登录界面
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}


