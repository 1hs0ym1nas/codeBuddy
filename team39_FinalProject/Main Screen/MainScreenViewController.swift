import UIKit
import Alamofire
import FirebaseAuth

class MainScreenViewController: UIViewController {
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    
    
    let mainScreenView = MainScreenView()
    
    override func loadView() {
        view = mainScreenView
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
            handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
                if user == nil{
                    self.switchLoggenIn()
                    
                }else{
                    //MARK: the user is signed in...
                    self.currentUser = user
                    self.mainScreenView.labelWelcome.text = "Welcome \(user?.displayName ?? "Anonymous")!"
                }
            }
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
        
        mainScreenView.button1.addTarget(self, action: #selector(onHButton1Tappped), for: .touchUpInside)
        mainScreenView.button2.addTarget(self, action: #selector(onHButton2Tappped), for: .touchUpInside)
        mainScreenView.button3.addTarget(self, action: #selector(onHButton3Tappped), for: .touchUpInside)
        mainScreenView.button4.addTarget(self, action: #selector(onHButton4Tappped), for: .touchUpInside)
        mainScreenView.button5.addTarget(self, action: #selector(onHButton5Tappped), for: .touchUpInside)
        mainScreenView.button6.addTarget(self, action: #selector(onHButton3Tappped), for: .touchUpInside)
        mainScreenView.button7.addTarget(self, action: #selector(onHButton4Tappped), for: .touchUpInside)
        mainScreenView.button8.addTarget(self, action: #selector(onHButton5Tappped), for: .touchUpInside)
    }
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    self.switchLoggenIn()
                    
                }catch{
                    print("Error occured!")
                }
            
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
    @objc func onHButton1Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Array"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button1Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton2Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button2Tag
        questionViewController.title = "String"
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton3Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Sliding window"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button3Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton4Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Two pointer"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button4Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton5Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Tree"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button5Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton6Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Graph"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button6Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton7Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Stack"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button7Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton8Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Queue"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button8Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    /*
    // need to be changed to log in story board name
    func switchLoggenIn() {
        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        if let logInNavigationController = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? UINavigationController {
            
            if let window = self.window {
                window.rootViewController = logInNavigationController
                window.makeKeyAndVisible()
            }
            else{
                print("no window initalized")
            }
        }
     */
        
    func switchLoggenIn() {
        // Tell the SceneDelegate to switch to the login screen
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.switchToLoginScreen()
        } else {
            print("SceneDelegate not found")
        }
    }
        
        
        /*
        let logInStoryBoard = UIStoryboard(name: "LogIn", bundle: nil)
        if let logInVC = logInStoryBoard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = logInVC
            window?.makeKeyAndVisible()
        }
         */
    
    
    /*
    func switchMainApp() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if let mainVC = mainStoryBoard.instantiateViewController(withIdentifier: "MainScreenViewController") as? MainScreenViewController {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = mainVC
            window?.makeKeyAndVisible()
        }
    }
     */
     


}


