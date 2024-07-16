//
//  HomeViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 6.07.2024.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController, HomePageViewDelegate{
 
    //MARK: -Properties
    private let homeView = HomePageView()
    var userModel: UserModel?
    let viewModel : HomeViewModel
    var authService: FirebaseAuthProtocol!

    //MARK: -Init
    init(userModel: UserModel, authService: FirebaseAuthProtocol) {
        self.userModel = userModel
        self.authService = authService
        self.viewModel = HomeViewModel(userModel: userModel)
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.addSubview(homeView)
        addCostraints()
        setupNavigationBar()
        
        if let userModel = userModel {
            homeView.titleLabel.text = "\(userModel.name) \(userModel.surname)"
            homeView.emailLabel.text = "\(userModel.email)"
        } else {
           homeView.titleLabel.text = "Profile Name"
        }
    }
    
    func addCostraints(){
        homeView.delegate = self
        homeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func logOutButtonTapped() {
        do {
            try authService.logOut()
            // Kullanıcıyı giriş ekranına yönlendir
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.setRootViewControllerToLogIn()
            }
        } catch {
            print("Logout failed: \(error)")
        }
    }
    
    func sendNewsButtonTapped() {
        
    }
    
  
    
    private func changeRootViewController(_ vc: UIViewController, animated: Bool = true){
        guard let window = view.window else {
                   print("Error: view.window is nil")
                   return
               }

               // window.windowScene kontrolü
               guard let windowScene = window.windowScene else {
                   print("Error: window.windowScene is nil")
                   return
               }

               // windowScene.windows kontrolü
               guard let firstWindow = windowScene.windows.first else {
                   print("Error: windowScene.windows.first is nil")
                   return
               }

               firstWindow.rootViewController = vc
               UIView.transition(with: firstWindow,
                                 duration: 0.5,
                                 options: [.transitionFlipFromRight],
                                 animations: nil,
                                 completion: nil)
    }
    
    func editProfileImageButtonTapped() {
        
    }
    
    private func setupNavigationBar() {
        
        // Like Button
        let editProfileButton = UIBarButtonItem(image: UIImage(systemName: "pencil.line"), style: .plain, target: self, action: #selector(didTapEditProfileButton))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItems = [settingsButton, editProfileButton]
    }
    
    @objc func didTapEditProfileButton(){
        let vc = ACSettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSettingsButton(){
        let vc = ACSettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
