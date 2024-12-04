//
//  LeaderboardView.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/4/24.
//

import UIKit

class LeaderboardView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Leaderboard"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let leaderboardTableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.clipsToBounds = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white

        addSubview(titleLabel)
        addSubview(leaderboardTableView)

        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Leaderboard TableView
            leaderboardTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            leaderboardTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            leaderboardTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            leaderboardTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
