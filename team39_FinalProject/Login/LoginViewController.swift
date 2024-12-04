//
//  LoginViewController.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/3/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    private let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        checkLoginState()
    }

    private func setupActions() {
        loginView.signInButton.addTarget(self, action: #selector(onSignInTapped), for: .touchUpInside)
        
        // Handle navigation to Sign Up
        loginView.onSignUpTapped = { [weak self] in
            self?.navigateToSignUp()
        }
    }
    
    private func navigateToSignUp() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }

    @objc private func onSignInTapped() {
        let email = loginView.emailTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""
        
        guard !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        guard !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.showAlert(message: error.localizedDescription)
            } else {
                // Show the success alert and navigate to Leaderboard on dismiss
                let alert = UIAlertController(
                    title: "Success",
                    message: "Logged in successfully!",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    let leaderboardVC = LeaderboardViewController()
                    self?.navigationController?.pushViewController(leaderboardVC, animated: true)
                }))
                self?.present(alert, animated: true)
            }
        }
    }

    private func checkLoginState() {
        if let _ = Auth.auth().currentUser {
            setupRightBarButton(isLoggedin: true)
        } else {
            setupRightBarButton(isLoggedin: false)
        }
    }

    private func setupRightBarButton(isLoggedin: Bool) {
        if isLoggedin {
            let barText = UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(onLogoutTapped)
            )
            navigationItem.rightBarButtonItem = barText
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }

    @objc private func onLogoutTapped() {
        do {
            try Auth.auth().signOut()
            showAlert(message: "Logged out successfully!")
            checkLoginState()
        } catch {
            showAlert(message: "Error signing out.")
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
