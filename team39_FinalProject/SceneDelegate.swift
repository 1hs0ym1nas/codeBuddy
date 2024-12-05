//
//  SceneDelegate.swift
//  team39_FinalProject
//
//  Created by Minghui Xu on 11/28/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        guard let winScene = (scene as? UIWindowScene) else { return }
        
        // we need to set it to false - for Thanda
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        
        // Retrieve the 'isLoggedIn' value from UserDefaults
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        // Initialize the window for the current window scene
        window = UIWindow(windowScene: winScene)
        
        // Check if the user is logged in
        if isLoggedIn {
            // Instantiate the main view controller from the "Main" storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                window?.rootViewController = mainVC
            }
        } else {
            // Instantiate the login view controller from the "LogIn" storyboard
            let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
            if let logInVC = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController {
                window?.rootViewController = logInVC
            }
        }
        
        // Make the window key and visible
        window?.makeKeyAndVisible()
    }
    
    /* Original version
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // guard let _ = (scene as? UIWindowScene) else { return }
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//                // 设置 Home Screen 作为初始页面
//                let homeScreen = HomeScreen()
//                let navigationController = UINavigationController(rootViewController: homeScreen)
//
//                window = UIWindow(windowScene: windowScene)
//                window?.rootViewController = navigationController
//                window?.makeKeyAndVisible()
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
     */

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

