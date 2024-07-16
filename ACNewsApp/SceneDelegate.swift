//
//  SceneDelegate.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
   
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let auth: FirebaseAuthProtocol = Auth.auth()
        let firestore: FirestoreProtocol = Firestore.firestore()

        // Kullanıcı oturum açmış mı kontrol et
        if let _ = Auth.auth().currentUser {
            // Kullanıcı oturum açmış tabbar göster
            print("oturum açık")
            let tabbarvc = ACTabbarViewController()
            window.rootViewController = tabbarvc
        } else {
            print("oturum kapalı")
            let viewModel = LogInViewModel(auth: auth, firestore: firestore)
            let loginvc = LogInViewController(viewModel: viewModel)
            window.rootViewController = loginvc
        }

        self.window = window
        window.makeKeyAndVisible()
    }
    
    func setRootViewControllerToLogIn() {
        let auth: FirebaseAuthProtocol = Auth.auth()
        let firestore: FirestoreProtocol = Firestore.firestore()

        let viewModel = LogInViewModel(auth: auth, firestore: firestore)
        let loginvc = LogInViewController(viewModel: viewModel)
        
        guard let window = self.window else {
            print("Error: window is nil")
            return
        }

        window.rootViewController = loginvc
        UIView.transition(with: window, duration: 0.5, options: [.transitionFlipFromRight], animations: nil, completion: nil)
    }
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
    

