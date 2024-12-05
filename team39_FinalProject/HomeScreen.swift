import UIKit

class HomeScreen: UIViewController {
    private let tableView = UITableView()

    // 模拟的 titleSlug 数据
    private let mockTitleSlugs = [
        "find-the-duplicate-number",
        "two-sum",
        "add-two-numbers"
    ]

    // 模拟的用户对象
    private var mockUser = User(
        userID: "123",
        userName: "Test User",
        profilePic: nil,
        email: "testuser@example.com",
        answers: [:],
        solvedQuestions: []
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mock Home Screen"
        view.backgroundColor = .white

        // 设置 TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
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

        // 跳转到 Question Screen
        let questionVC = QuestionViewController(titleSlug: selectedSlug, user: mockUser)
        navigationController?.pushViewController(questionVC, animated: true)
    }
}

