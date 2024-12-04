//
//  LeaderboardCell.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/4/24.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    private let crownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "crown.fill")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true // Hidden by default
        return imageView
    }()

    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(crownImageView)
        contentView.addSubview(rankLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(scoreLabel)

        NSLayoutConstraint.activate([
            // Crown Icon
            crownImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            crownImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            crownImageView.widthAnchor.constraint(equalToConstant: 30),
            crownImageView.heightAnchor.constraint(equalToConstant: 30),

            // Rank Label
            rankLabel.leadingAnchor.constraint(equalTo: crownImageView.trailingAnchor, constant: 10),
            rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankLabel.widthAnchor.constraint(equalToConstant: 40),

            // Name Label
            nameLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            // Score Label
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            scoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(rank: Int, name: String, score: Int) {
        rankLabel.text = "\(rank)"
        nameLabel.text = name
        scoreLabel.text = "\(score) pts"

        // Set crown visibility and background color based on rank
        crownImageView.isHidden = rank != 1

        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
}

