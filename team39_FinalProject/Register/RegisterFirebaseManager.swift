//
//  RegisterFirebaseManager.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/3/24.
//

import Foundation
import FirebaseAuth
import UIKit

extension RegisterViewController {
    
    func registerNewAccount() {
            guard let name = registerView.usernameTextField.text, !name.isEmpty else {
            showAlert(message: "Username field cannot be empty.")
            return
        }
        
        guard let email = registerView.emailTextField.text, !email.isEmpty, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }
        
        guard let password = registerView.passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Password field cannot be empty.")
            return
        }
        
        // Create Firebase user with email and password
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error == nil {
                // The user creation is successful, set the display name
                self.setNameOfTheUserInFirebaseAuth(name: name)
            } else {
                self.showAlert(message: error?.localizedDescription ?? "An error occurred. Please try again.")
            }
        }
    }
    
    // Helper function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }

    // Helper function to show alerts
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Set the name of the user after account creation
    func setNameOfTheUserInFirebaseAuth(name: String) {
        guard let currentUser = Auth.auth().currentUser else {
            showAlert(message: "Unable to retrieve user information. Please try again.")
            return
        }
        
        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.displayName = name
        changeRequest.commitChanges { error in
            if error == nil {
                // Profile update is successful, return to the previous screen
                self.navigationController?.popViewController(animated: true)
            } else {
                // Show error if profile update fails
                self.showAlert(message: "Failed to update profile: \(error!.localizedDescription)")
            }
        }
    }
}