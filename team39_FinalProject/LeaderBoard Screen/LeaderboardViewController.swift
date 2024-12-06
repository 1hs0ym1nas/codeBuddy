//
//  LeaderboardViewController.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/4/24.
//

import UIKit
import Firebase

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let leaderboardView = LeaderboardView()
    private var users: [(name: String, score: Int)] = [] // Leaderboard data from Firestore

    override func loadView() {
        view = leaderboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchLeaderboardData()
    }

    private func setupTableView() {
        leaderboardView.leaderboardTableView.dataSource = self
        leaderboardView.leaderboardTableView.delegate = self
        leaderboardView.leaderboardTableView.register(LeaderboardCell.self, forCellReuseIdentifier: "LeaderboardCell")
        leaderboardView.leaderboardTableView.separatorStyle = .none
    }

    private func fetchLeaderboardData() {
        let db = Firestore.firestore()
        
        // Access the "users" collection and query for leaderboard data
        db.collection("users")
            .order(by: "score", descending: true) // Order by score in descending order
            .limit(to: 3) // Fetch top 10 users
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching leaderboard data: \(error.localizedDescription)")
                    return
                }

                // Clear existing users
                self?.users.removeAll()

                // Parse Firestore documents
                for document in querySnapshot?.documents ?? [] {
                    let data = document.data()
                    if let username = data["username"] as? String,
                       let score = data["score"] as? Int {
                        self?.users.append((name: username, score: score))
                    }
                }

                // Reload the table view on the main thread
                DispatchQueue.main.async {
                    self?.leaderboardView.leaderboardTableView.reloadData()
                }
            }
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as? LeaderboardCell else {
            return UITableViewCell()
        }

        let user = users[indexPath.row]
        cell.configure(rank: indexPath.row + 1, name: user.name, score: user.score)
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust cell height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // Space between cells
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Space between cells
    }
}
