//
//  UserProfileTestViewController.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/29.
//

import UIKit
import FirebaseAuth


class UserProfileTestViewController: UIViewController {

    // MARK: - Properties
    private let userProfileView = UserProfileView(frame: UIScreen.main.bounds)
    private var username: String = "" // 初始用户名为空，等待从 Firebase 加载
    private var email: String = "" // 初始邮箱为空
    private var score: Int = 0 // 初始分数
    private var profileImage: UIImage? = UIImage(named: "profile_placeholder") // 默认头像占位图

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("View did load") // 调试日志

        // 添加 UserProfileView
        view.addSubview(userProfileView)

        // 配置页面按钮行为
        setupEditButtonAction()
        authenticateUser()
        
    }
    private func authenticateUser() {
        if let currentUser = Auth.auth().currentUser {
                // 如果用户已登录
                print("User already logged in: \(currentUser.uid), displayName: \(currentUser.displayName ?? "Unknown User")")
                
                // 在这里可以执行已登录用户的相关操作
                // 比如更新 UI 或从 Firebase 获取用户数据
                fetchUserProfileFromFirebase()

            } else {
                // 如果用户没有登录，提示用户登录
                print("No user logged in.")
                // 你可以选择跳转到登录界面，或者弹出登录框
                showLoginAlert()
            }
    }
    
    // 提示用户登录的弹框
    private func showLoginAlert() {
        let alert = UIAlertController(
            title: "Not Logged In",
            message: "You need to log in to add comments.",
            preferredStyle: .alert
        )
        let loginAction = UIAlertAction(title: "Log In", style: .default) { _ in
            self.redirectToLogin()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(loginAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    // 跳转到登录页面的逻辑
    private func redirectToLogin() {
        
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
        
    }

    // MARK: - Firebase Data Fetch
    private func fetchUserProfileFromFirebase() {
        FirebaseManager.shared.fetchUserProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                print("Fetched user profile data: \(data)")

                // 更新数据
                self.username = data["userName"] as? String ?? "Unknown User"
                self.email = data["email"] as? String ?? "unknown@example.com"
                
                // 通过 solvedQuestions 数组的长度来计算 score
                if let solvedQuestions = data["solvedQuestions"] as? [String] {
                    self.score = solvedQuestions.count
                } else {
                    self.score = 0
                }

                // 如果有头像 URL，从网络加载图片
                if let profileImageURL = data["profileImageURL"] as? String {
                    self.loadProfileImage(from: profileImageURL)
                }

                // 更新界面
                DispatchQueue.main.async {
                    self.updateUserProfileView()
                }

            case .failure(let error):
                print("Failed to fetch user profile: \(error.localizedDescription)")
            }
        }
    }

    private func loadProfileImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Failed to load profile image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.profileImage = image
                    self?.userProfileView.profileImageView.image = image
                }
            }
        }.resume()
    }

    // MARK: - Setup Methods
    private func updateUserProfileView() {
        userProfileView.usernameLabel.text = username
        userProfileView.emailLabel.text = email
        userProfileView.scoreLabel.text = "Score: \(score)"
        userProfileView.profileImageView.image = profileImage
        print("Updated User Profile View - Username: \(username), Email: \(email), Score: \(score)") // 调试日志
    }

    private func setupEditButtonAction() {
        // 配置页面中 `Edit` 按钮的行为
        userProfileView.onEditButtonTapped = { [weak self] in
            self?.navigateToEditPage()
        }
        print("Page Edit button action set up") // 调试日志
    }

    // MARK: - Actions
    private func navigateToEditPage() {
        print("Navigating to Edit Profile Page") // 调试日志

        let editViewController = EditProfileViewController()
        editViewController.username = username
        editViewController.profileImage = profileImage

        // 设置保存回调
        editViewController.onSave = { [weak self] updatedUsername, updatedImage in
            guard let self = self else { return }

            // 更新 Firebase 数据
            FirebaseManager.shared.uploadProfileImage(image: updatedImage ?? UIImage()) { result in
                switch result {
                case .success(let imageURL):
                    // 只传递 username 和 imageURL，不再传递 email
                    FirebaseManager.shared.updateUserProfile(username: updatedUsername, profileImageURL: imageURL) { result in
                        switch result {
                        case .success:
                            print("User profile updated successfully.")
                        case .failure(let error):
                            print("Failed to update user profile: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("Failed to upload profile image: \(error.localizedDescription)")
                }
            }

            // 更新本地 UI
            self.username = updatedUsername
            self.profileImage = updatedImage
            self.updateUserProfileView()
            print("Profile updated successfully.")
        }

        // 使用现有的导航控制器进行跳转
        navigationController?.pushViewController(editViewController, animated: true)
    }
}
