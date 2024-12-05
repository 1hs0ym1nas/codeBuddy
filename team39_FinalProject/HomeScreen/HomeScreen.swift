import UIKit
import FirebaseAuth

class HomeScreen: UIViewController {
    private let tableView = UITableView()

    // 模拟的 titleSlug 数据
    private let mockTitleSlugs = [
        "find-the-duplicate-number",
        "two-sum",
        "add-two-numbers"
    ]

    private var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Screen"
        view.backgroundColor = .white

        
        authenticateUser()

        // 设置 TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }

    private func authenticateUser() {
        if let user = Auth.auth().currentUser {
            
            fetchUserProfile(userID: user.uid)
        } else {
            
            showLoginAlert()
        }
    }

    private func fetchUserProfile(userID: String) {
        
        FirebaseManager.shared.fetchUserProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                
                let user = User(userID: userID, userName: data["userName"] as? String ?? "Unknown User", email: data["email"] as? String ?? "unknown@example.com")
                self.currentUser = user
            case .failure(let error):
                print("Failed to fetch user profile: \(error.localizedDescription)")
            }
        }
    }

    private func showLoginAlert() {
        let alert = UIAlertController(title: "Not Logged In", message: "Please log in to view the questions.", preferredStyle: .alert)
        let loginAction = UIAlertAction(title: "Log In", style: .default) { _ in
            self.redirectToLogin()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    private func redirectToLogin() {
        
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}

extension HomeScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockTitleSlugs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = mockTitleSlugs[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSlug = mockTitleSlugs[indexPath.row]

        
        if let user = currentUser {
            let questionVC = QuestionViewController(titleSlug: selectedSlug, user: user)
            navigationController?.pushViewController(questionVC, animated: true)
        } else {
            print("User not logged in, cannot proceed.")
            
        }
    }
}

