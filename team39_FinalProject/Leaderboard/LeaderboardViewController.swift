//
//  LeaderboardViewController.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/4/24.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let leaderboardView = LeaderboardView()
    private var users: [(name: String, score: Int)] = [] // Sample leaderboard data

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
        // Fetch leaderboard data (sample data for now)
        users = [
            ("Alice", 120),
            ("Bob", 110),
            ("Charlie", 105),
            ("David", 100),
            ("Eve", 95)
        ]

        // Sort users by score in descending order and limit to top 3
        users = Array(users.sorted { $0.score > $1.score }.prefix(3))
        leaderboardView.leaderboardTableView.reloadData()
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
