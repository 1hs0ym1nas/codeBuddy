//
//  UserProfileView.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/28.
//

import UIKit

class UserProfileView: UIView {

    // MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile" // 显示 "Profile" 作为标题
        label.font = UIFont(name: "RobotoSerif28ptCondensed-Black", size: 35) // 使用 Roboto Serif 加粗
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray // 背景色灰色模拟头像
        return imageView
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RobotoSerif28ptCondensed-Black", size: 28) // 使用 Roboto Serif
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RobotoSerif28ptCondensed-Bold", size: 25) // 使用 Roboto Serif
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()

    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RobotoSerif28ptCondensed-Bold", size: 25) // 使用 Roboto Serif
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.text = "Score: 0" // 默认分数
        return label
    }()

    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont(name: "RobotoSerif28ptCondensed-Bold", size: 20) // 使用 Roboto Serif
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    // MARK: - Callback
    var onEditButtonTapped: (() -> Void)?

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = .white

        // 添加子视图
        addSubview(titleLabel)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(emailLabel)
        addSubview(scoreLabel)
        addSubview(editButton)

        // 设置约束
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Edit Button
            editButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Profile Image
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50), // 增加间距
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 150), // 修改宽度为 150
            profileImageView.heightAnchor.constraint(equalToConstant: 150), // 修改高度为 150

            // Username Label
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40), // 调整间距
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Email Label
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Score Label
            scoreLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Setup Actions
    private func setupActions() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }

    @objc private func editButtonTapped() {
        onEditButtonTapped?()
    }
}
