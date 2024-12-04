//
//  EditProfileView.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/29.
//

import UIKit

class EditProfileView: UIView {

    // MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit Profile" // Title for Edit Profile screen
        label.font = UIFont(name: "RobotoSerif28ptCondensed-Black", size: 35)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    let changePhotoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your username"
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "RobotoSerif28ptCondensed-Bold", size: 20)
        textField.textAlignment = .center
        return textField
    }()

    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont(name: "RobotoSerif28ptCondensed-Bold", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = .white

        // Add subviews
        addSubview(titleLabel)
        addSubview(profileImageView)
        addSubview(changePhotoButton)
        addSubview(usernameTextField)
        // saveButton is commented out to avoid duplication
        // addSubview(saveButton)

        // Setup constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            // Profile Image
            profileImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),

            // Change Photo Button
            changePhotoButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -5),
            changePhotoButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -5),
            changePhotoButton.widthAnchor.constraint(equalToConstant: 40),
            changePhotoButton.heightAnchor.constraint(equalToConstant: 40),

            // Username TextField
            usernameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)

            // Save Button constraints are commented out
            /*
            saveButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
            */
        ])
    }
}
