//
//  FirebaseTestHelper.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/29.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseTestHelper {
    /// 创建测试用户并设置 `displayName`，并将 `displayName` 保存到 Firestore
    static func createTestUser(email: String, password: String, displayName: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Failed to create user: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let user = authResult?.user else {
                completion(false)
                return
            }

            // 更新用户的 displayName
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = displayName
            changeRequest.commitChanges { error in
                if let error = error {
                    print("Failed to update displayName: \(error.localizedDescription)")
                    completion(false)
                    return
                } else {
                    print("User created successfully with displayName: \(displayName)")
                    
                    // 确保 displayName 被正确更新
                    Auth.auth().currentUser?.reload { reloadError in
                        if let reloadError = reloadError {
                            print("Failed to reload user: \(reloadError.localizedDescription)")
                            completion(false)
                            return
                        }
                        
                        // 将用户 displayName 保存到 Firestore
                        guard let userID = Auth.auth().currentUser?.uid else {
                            completion(false)
                            return
                        }

                        let db = Firestore.firestore()
                        let userDoc = db.collection("users").document(userID)
                        userDoc.setData([
                            "userName": displayName,
                            "email": email
                        ], merge: true) { error in
                            if let error = error {
                                print("Failed to save user profile to Firestore: \(error.localizedDescription)")
                                completion(false)
                            } else {
                                print("User profile saved to Firestore successfully.")
                                completion(true)
                            }
                        }
                    }
                }
            }
        }
    }

    /// 模拟用户登录
    static func simulateUserLogin(for email: String, password: String, completion: @escaping (Bool) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            print("User already logged in: \(currentUser.uid), displayName: \(currentUser.displayName ?? "Unknown")")
            completion(true)
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Login failed with error: \(error.localizedDescription)")
                completion(false)
                return
            }

            if let user = authResult?.user {
                print("Successfully logged in with userID: \(user.uid), displayName: \(user.displayName ?? "Unknown")")
                completion(true)
            } else {
                print("Login failed: Unknown error")
                completion(false)
            }
        }
    }

    /// 注册并登录用户（用于测试）
    static func simulateUserSignUp(for email: String, password: String, displayName: String, completion: @escaping (Bool) -> Void) {
        createTestUser(email: email, password: password, displayName: displayName) { success in
            if success {
                simulateUserLogin(for: email, password: password, completion: completion)
            } else {
                completion(false)
            }
        }
    }
}

