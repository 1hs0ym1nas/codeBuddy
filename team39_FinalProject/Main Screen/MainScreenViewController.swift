import UIKit
import Firebase
import FirebaseAuth

class MainScreenViewController: UIViewController {
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser: FirebaseAuth.User?
    let mainScreenView = MainScreenView()
    
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the bar button item
        let barIcon = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
            style: .plain,
            target: self,
            action: #selector(onLogOutBarButtonTapped)
        )
        
        // Set the right bar button item
        navigationItem.rightBarButtonItem = barIcon
        
        // Set up button actions
        mainScreenView.button1.addTarget(self, action: #selector(onHButton1Tappped), for: .touchUpInside)
        mainScreenView.button2.addTarget(self, action: #selector(onHButton2Tappped), for: .touchUpInside)
        mainScreenView.button3.addTarget(self, action: #selector(onHButton3Tappped), for: .touchUpInside)
        mainScreenView.button4.addTarget(self, action: #selector(onHButton4Tappped), for: .touchUpInside)
        mainScreenView.button5.addTarget(self, action: #selector(onHButton5Tappped), for: .touchUpInside)
        mainScreenView.button6.addTarget(self, action: #selector(onHButton6Tappped), for: .touchUpInside)
        mainScreenView.button7.addTarget(self, action: #selector(onHButton7Tappped), for: .touchUpInside)
        mainScreenView.button8.addTarget(self, action: #selector(onHButton8Tappped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch the updated username from Firestore
        fetchUpdatedUsername()
    }
    
    private func fetchUpdatedUsername() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("No current user logged in.")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(currentUserID).getDocument { [weak self] document, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }
            
            guard let self = self, let data = document?.data(), let updatedUsername = data["userName"] as? String else {
                print("Failed to parse user data.")
                return
            }
            
            // Update the welcome label
            DispatchQueue.main.async {
                self.mainScreenView.labelWelcome.text = "Welcome \(updatedUsername)!"
            }
        }
    }
    
    @objc func onLogOutBarButtonTapped() {
        let logoutAlert = UIAlertController(
            title: "Logging out!",
            message: "Are you sure want to log out?",
            preferredStyle: .actionSheet
        )
        
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            do {
                try Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                self.switchLoggenIn()
            } catch {
                print("Error occurred while logging out!")
            }
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(logoutAlert, animated: true)
    }
    
    func switchLoggenIn() {
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.switchToLoginScreen()
        } else {
            print("SceneDelegate not found")
        }
    }
    
    // Button action methods remain unchanged
    @objc func onHButton1Tappped() {
        navigateToQuestionScreen(title: "Array", urlTag: APIConfigs.button1Tag)
    }
    
    @objc func onHButton2Tappped() {
        navigateToQuestionScreen(title: "String", urlTag: APIConfigs.button2Tag)
    }
    
    @objc func onHButton3Tappped() {
        navigateToQuestionScreen(title: "Sliding window", urlTag: APIConfigs.button3Tag)
    }
    
    @objc func onHButton4Tappped() {
        navigateToQuestionScreen(title: "Two pointer", urlTag: APIConfigs.button4Tag)
    }
    
    @objc func onHButton5Tappped() {
        navigateToQuestionScreen(title: "Tree", urlTag: APIConfigs.button5Tag)
    }
    
    @objc func onHButton6Tappped() {
        navigateToQuestionScreen(title: "Graph", urlTag: APIConfigs.button6Tag)
    }
    
    @objc func onHButton7Tappped() {
        navigateToQuestionScreen(title: "Stack", urlTag: APIConfigs.button7Tag)
    }
    
    @objc func onHButton8Tappped() {
        navigateToQuestionScreen(title: "Queue", urlTag: APIConfigs.button8Tag)
    }
    
    private func navigateToQuestionScreen(title: String, urlTag: String) {
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = title
        questionViewController.passUrl = APIConfigs.baseURL + urlTag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
}
