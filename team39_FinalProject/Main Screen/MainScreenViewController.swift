import UIKit
import Alamofire
import FirebaseAuth

class MainScreenViewController: UIViewController {
    
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
        
        mainScreenView.button1.addTarget(self, action: #selector(onHButton1Tappped), for: .touchUpInside)
        mainScreenView.button2.addTarget(self, action: #selector(onHButton2Tappped), for: .touchUpInside)
        mainScreenView.button3.addTarget(self, action: #selector(onHButton3Tappped), for: .touchUpInside)
        mainScreenView.button4.addTarget(self, action: #selector(onHButton4Tappped), for: .touchUpInside)
        mainScreenView.button5.addTarget(self, action: #selector(onHButton5Tappped), for: .touchUpInside)
    }
    @objc func onLogOutBarButtonTapped(){
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?",
            preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    try Auth.auth().signOut()
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
        questionViewController.title = "Array & String"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button1Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton2Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button2Tag
        questionViewController.title = "Sliding Window & Two Pointers"
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton3Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Tree & Recursion"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button3Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton4Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Math & Hash Table"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button4Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    @objc func onHButton5Tappped(){
        // creating a new user on Firebase
        let questionViewController = QuestionScreenViewController()
        questionViewController.title = "Stack & Queue"
        questionViewController.passUrl = APIConfigs.baseURL + APIConfigs.button5Tag
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }


}


