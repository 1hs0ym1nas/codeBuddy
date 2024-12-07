//
//  RegisterViewController.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/3/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    let registerView = RegisterView()
    
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.signUpButton.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        setupActions()
    }
    
    private func setupActions() {
        registerView.onSignInTapped = { [weak self] in
            self?.navigateToSignIn()
        }
    }
    
    private func navigateToSignIn() {
        // Navigate explicitly to LoginViewController
        if let navigationController = navigationController {
            for controller in navigationController.viewControllers {
                if controller is LoginViewControllerMain {
                    navigationController.popToViewController(controller, animated: true)
                    return
                }
            }
        }
        
        // If LoginViewController is not in the stack, push it
        let loginViewController = LoginViewControllerMain()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc private func onRegisterTapped() {
        registerNewAccount { isSuccess in
            if isSuccess {
                // Show success alert only on successful registration
                let alert = UIAlertController(
                    title: "Success",
                    message: "Registered successfully! Please log in.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}
