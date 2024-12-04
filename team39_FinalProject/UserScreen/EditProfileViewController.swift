//
//  EditProfileViewController.swift
//  team39_FinalProject
//
//  Created by yan ran on 2024/11/29.
//

import UIKit



class EditProfileViewController: UIViewController {

    // MARK: - Properties
    var username: String = "" // 用于接收用户名
    var profileImage: UIImage? = nil // 用于接收头像
    var onSave: ((String, UIImage?) -> Void)? // 保存后的回调

    private let editProfileView = EditProfileView(frame: UIScreen.main.bounds)
    private var isSaving = false // 防止多次触发保存

    // MARK: - Lifecycle
    override func loadView() {
        self.view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Setup View
    private func setupView() {
        // 设置初始值
        editProfileView.usernameTextField.text = username
        editProfileView.profileImageView.image = profileImage ?? UIImage(systemName: "person.circle")

        // 设置导航栏保存按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )

        // 添加更换头像按钮的操作
        //editProfileView.changePhotoButton.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func saveButtonTapped() {
        guard !isSaving else { return } // 防止重复保存
        isSaving = true

        let updatedUsername = editProfileView.usernameTextField.text ?? ""
        //let updatedImage = editProfileView.profileImageView.image

        print("Save button tapped. Updated username: \(updatedUsername)")

        // 检查用户登录状态
        guard let currentUserID = FirebaseManager.shared.getCurrentUserID() else {
            print("User not logged in. Prompting user to log in.")
            isSaving = false
            showAlertForLogin()
            return
        }
        
        updateUserProfile(username: updatedUsername, profileImageURL: nil)
        
        /*

        if let updatedImage = updatedImage {
            // 上传头像到 Firebase Storage
            FirebaseManager.shared.uploadProfileImage(image: updatedImage) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let imageURL):
                    print("Profile image uploaded. URL: \(imageURL)")

                    // 更新用户名和头像 URL 到 Firebase
                    self.updateUserProfile(username: updatedUsername, profileImageURL: imageURL)

                case .failure(let error):
                    print("Failed to upload profile image: \(error.localizedDescription)")
                    self.isSaving = false
                }
            }
        } else {
            // 如果没有头像更新，仅更新用户名
            
        }
         */
    }

    private func updateUserProfile(username: String, profileImageURL: String?) {
        FirebaseManager.shared.updateUserProfile(username: username, profileImageURL: profileImageURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                print("User profile updated successfully.")

                // 执行保存回调
                if let onSave = self.onSave {
                    onSave(username, self.editProfileView.profileImageView.image)
                }

                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print("Failed to update user profile: \(error.localizedDescription)")
            }
            self.isSaving = false
        }
    }
    
    /*

    @objc private func changePhotoTapped() {
        let alertController = UIAlertController(title: "Change Photo", message: "Choose a source", preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Helper Methods
    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available")
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }

    private func openPhotoLibrary() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("Photo Library not available")
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
     */

    private func showAlertForLogin() {
        let alert = UIAlertController(title: "Not Logged In", message: "Please log in to save changes.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

/*
// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // 更新头像
            editProfileView.profileImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
*/
