//
//  FirebaseManager.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/29.
//

import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class FirebaseManager {
    // 单例
    static let shared = FirebaseManager()

    // Firestore 和 Storage 的引用
    private let db = Firestore.firestore()
    private let storage = Storage.storage()

    private init() {}

    // MARK: - 用户数据操作

    /// 获取当前用户 ID
    func getCurrentUserID() -> String? {
        if let currentUser = Auth.auth().currentUser {
            print("Current User ID: \(currentUser.uid)") // 打印用户 ID
            return currentUser.uid
        } else {
            print("No user is currently logged in.")
            return nil
        }
    }

    /// 获取用户信息
    func fetchUserProfile(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let userID = getCurrentUserID() else {
            completion(.failure(NSError(domain: "FirebaseManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
            return
        }

        db.collection("users").document(userID).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = document?.data() {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "FirebaseManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "User profile not found"])))
            }
        }
    }

    /// 更新用户信息
    func updateUserProfile(username: String, profileImageURL: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = getCurrentUserID() else {
            completion(.failure(NSError(domain: "FirebaseManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
            return
        }

        // 获取当前用户的文档
        db.collection("users").document(userID).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = document?.data(), let currentEmail = data["email"] as? String else {
                completion(.failure(NSError(domain: "FirebaseManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "User profile not found"])))
                return
            }

            // 更新数据，只更改 userName 和 profileImageURL，保留 email 字段
            var updatedData: [String: Any] = [
                "userName": username,
                "email": currentEmail // 保持 email 字段不变
            ]
            
            if let profileImageURL = profileImageURL {
                updatedData["profileImageURL"] = profileImageURL // 如果有头像图片则更新
            }

            // 更新 Firestore 中的用户数据
            self.db.collection("users").document(userID).setData(updatedData, merge: true) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    // MARK: - 图片操作

    /// 上传头像图片到 Firebase Storage
    func uploadProfileImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let userID = getCurrentUserID() else {
            completion(.failure(NSError(domain: "FirebaseManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])))
            return
        }

        let storageRef = storage.reference().child("profile_images/\(userID).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "FirebaseManager", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }

        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }
}
