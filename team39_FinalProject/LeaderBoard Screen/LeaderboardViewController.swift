//
//  LeaderboardViewController.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/4/24.
//

import UIKit
import Firebase
import FirebaseFirestore

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let leaderboardView = LeaderboardView()
    private var users: [User] = [] // Leaderboard data from Firestore as User objects

    override func loadView() {
        view = leaderboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchLeaderboardData() // Initial data fetch
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchLeaderboardData() // Refresh data every time the view appears
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
            .limit(to: 3) // Fetch top 3 users
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching leaderboard data: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No leaderboard data found")
                    return
                }

                // Decode Firestore documents into User objects
                self?.users = documents.compactMap { document in
                    try? document.data(as: User.self) // Decode directly to User model
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
        cell.configure(rank: indexPath.row + 1, name: user.userName, score: user.score)
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
