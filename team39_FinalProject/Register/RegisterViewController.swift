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
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onRegisterTapped(){
        // creating a new user on Firebase
        registerNewAccount()
    }
    
    
}
