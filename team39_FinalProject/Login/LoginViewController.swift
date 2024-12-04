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
        // Attach actions to buttons in the login view
        loginView.signInButton.addTarget(self, action: #selector(onSignInTapped), for: .touchUpInside)
    }
    
    @objc private func onSignInTapped() {
        let email = loginView.emailTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""
        
        // Validate fields
        guard !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        guard !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        
        // Attempt Firebase sign-in
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.showAlert(message: error.localizedDescription)
            } else {
                self?.showAlert(message: "Logged in successfully!")
                self?.checkLoginState()
            }
        }
    }

    private func checkLoginState() {
        // Determine if a user is logged in and update the navigation bar
        if let _ = Auth.auth().currentUser {
            setupRightBarButton(isLoggedin: true)
        } else {
            setupRightBarButton(isLoggedin: false)
        }
    }

    private func setupRightBarButton(isLoggedin: Bool) {
        if isLoggedin {
            // Show Logout button only if logged in
            let barIcon = UIBarButtonItem(
                image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
                style: .plain,
                target: self,
                action: #selector(onLogoutTapped)
            )
            let barText = UIBarButtonItem(
                title: "Logout",
                style: .plain,
                target: self,
                action: #selector(onLogoutTapped)
            )
            navigationItem.rightBarButtonItems = [barIcon, barText]
        } else {
            // Remove navigation items if not logged in
            navigationItem.rightBarButtonItems = nil
        }
    }

    @objc private func onRegisterTapped() {
        // Navigate to the Register screen
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }

    @objc private func onLogoutTapped() {
        let alert = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to log out?",
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive) { _ in
            do {
                try Auth.auth().signOut()
                self.showAlert(message: "Logged out successfully!")
                self.checkLoginState()
            } catch {
                self.showAlert(message: "Error signing out.")
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
