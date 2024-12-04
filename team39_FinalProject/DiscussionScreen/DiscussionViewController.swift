//
//  DiscussionViewController.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/30.
//

import UIKit
import FirebaseAuth

class DiscussionViewController: UIViewController {

    // MARK: - Properties
    private let discussionView = DiscussionView()
    private var comments: [Comment] = [] // 用于存储评论的数组
    private var filteredComments: [Comment] = [] // 用于搜索后的过滤结果
    private var isSearching = false // 判断是否在搜索
    private let commentManager = CommentManager() // 用于管理评论的 Firebase 交互

    // 日期格式化器（全局属性，避免重复创建）
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm" // 格式化为 月/日/年 时:分
        return formatter
    }()

    // MARK: - Lifecycle
    override func loadView() {
        self.view = discussionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
        setupView()
        
    }
    
    private func authenticateUser() {
        if let currentUser = Auth.auth().currentUser {
            print("User already logged in: \(currentUser.uid), displayName: \(currentUser.displayName ?? "Unknown User")")
            // 用户已经登录，执行相关操作，例如获取用户信息、更新UI等
            loadCommentsFromFirebase()
        } else {
            print("No user logged in.")
            // 用户未登录，执行登录或引导用户登录的操作
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

    deinit {
        commentManager.stopListening()
    }

    // MARK: - Setup View
    private func setupView() {
        // 设置 TableView 的数据源和代理
        discussionView.commentsTableView.dataSource = self
        discussionView.commentsTableView.delegate = self
        
        // 设置 SearchBar 的代理
        discussionView.searchBar.delegate = self

        // 设置 Add Button 点击事件
        discussionView.addButton.addTarget(self, action: #selector(addCommentTapped), for: .touchUpInside)
    }

    // MARK: - Firebase Data
    private func loadCommentsFromFirebase() {
        commentManager.startListening { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let loadedComments):
                self.comments = loadedComments
                DispatchQueue.main.async {
                    self.discussionView.commentsTableView.reloadData()
                }
            case .failure(let error):
                print("Failed to load comments: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Actions
    @objc private func addCommentTapped() {
        let addCommentVC = AddCommentViewController()
        addCommentVC.onSave = { [weak self] commentText in
            guard let self = self else { return }

            // 确保当前用户已登录
            guard let currentUser = Auth.auth().currentUser else {
                print("Error: User is not logged in")
                return
            }
            
            // 打印当前用户信息
            print("Current User ID: \(currentUser.uid)")
            print("Current User Display Name: \(currentUser.displayName ?? "Unknown User")")

            // 获取用户 ID 和用户名
            let userID = currentUser.uid
            let userName = currentUser.displayName ?? "Unknown User"

            // 创建新评论对象
            let newComment = Comment(
                text: commentText,
                userID: userID,
                userName: userName,
                timestamp: Date()
            )

            // 保存评论到 Firebase
            self.commentManager.addComment(newComment) { result in
                switch result {
                case .success:
                    print("Comment added successfully.")
                case .failure(let error):
                    print("Failed to add comment: \(error.localizedDescription)")
                }
            }
        }
        present(addCommentVC, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension DiscussionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredComments.count : comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)
        let comment = isSearching ? filteredComments[indexPath.row] : comments[indexPath.row]
        
        // 格式化时间戳
        let formattedTimestamp = dateFormatter.string(from: comment.timestamp)
        
        // 获取评论的第一行
        let firstLine = comment.text.components(separatedBy: "\n").first ?? comment.text
        
        // 设置显示内容
        cell.textLabel?.text = "\(comment.userName): \(firstLine)    \(formattedTimestamp)"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DiscussionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = isSearching ? filteredComments[indexPath.row] : comments[indexPath.row]
        
        // 显示完整评论内容的弹框
        let alertController = UIAlertController(
            title: "Comment Content",
            message: "\(comment.userName):\n\n\(comment.text)",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let comment = isSearching ? filteredComments[indexPath.row] : comments[indexPath.row]
                
                // 判断是否有权限删除
                if comment.userID == Auth.auth().currentUser?.uid {
                    showDeleteConfirmation(comment, at: indexPath)
                } else {
                    showPermissionDeniedAlert()
                }
            }
        }
}

// MARK: - UISearchBarDelegate
extension DiscussionViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredComments = comments.filter {
                $0.text.lowercased().contains(searchText.lowercased()) ||
                $0.userName.lowercased().contains(searchText.lowercased())
            }
        }
        discussionView.commentsTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        discussionView.commentsTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension DiscussionViewController {
    /// 显示没有权限删除评论的提示框
    private func showPermissionDeniedAlert() {
        let alert = UIAlertController(
            title: "Permission Denied",
            message: "You can only delete your own comments.",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    /// 显示确认删除的提示框
    private func showDeleteConfirmation(_ comment: Comment, at indexPath: IndexPath) {
        let alert = UIAlertController(
            title: "Confirm Delete",
            message: "Are you sure you want to delete this comment?",
            preferredStyle: .alert
        )
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteComment(comment, at: indexPath)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    private func deleteComment(_ comment: Comment, at indexPath: IndexPath) {
            // 检查用户是否有权限删除
            guard let currentUser = Auth.auth().currentUser, currentUser.uid == comment.userID else {
                showPermissionDeniedAlert()
                return
            }

            // 调用 CommentManager 来从 Firebase 中删除评论
            commentManager.deleteComment(comment) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    print("Comment deleted successfully.")
                    // 从本地数组中移除该评论
                    self.comments.remove(at: indexPath.row)
                    //self.discussionView.commentsTableView.deleteRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    print("Failed to delete comment: \(error.localizedDescription)")
                }
            }
        }
}
