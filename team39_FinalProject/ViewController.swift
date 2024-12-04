//
//  ViewController.swift
//  team39_FinalProject
//
//  Created by Thanda Myo Win on 12/3/24.
//

import UIKit

class ViewController: UIViewController {
    private let landingView = LandingView()

    override func loadView() {
        view = landingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        landingView.signInButton.addTarget(self, action: #selector(onSignInTapped), for: .touchUpInside)
        landingView.signUpButton.addTarget(self, action: #selector(onSignUpTapped), for: .touchUpInside)
    }
    
    @objc private func onSignInTapped() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc private func onSignUpTapped() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
