//
//  HomeViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 6.07.2024.
//

import UIKit
import FirebaseFirestore

class HomeViewController: UIViewController, HomePageViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
 
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
        
       updateUserInfo()
    }
    
    func updateUserInfo() {
            if let userModel = userModel {
                // Update UI with user info
                homeView.titleLabel.text = "\(userModel.name) \(userModel.surname)"
                homeView.emailLabel.text = userModel.email
                print("isim soyisim geldi: \(userModel.name)")
            } else {
                // Fallback if userModel is nil (should not happen if properly initialized)
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
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.showImagePicker(sourceType: .camera)
        }
        let galleryAction = UIAlertAction(title: "Select from gallery", style: .default) { _ in
            self.showImagePicker(sourceType: .photoLibrary)
        }
        
        let removeAction = UIAlertAction(title: "Remove image", style: .default) { _ in
            self.homeView.profileImage.image = UIImage(named: "profileImage")
        }
        
        if homeView.profileImage.image != UIImage(named: "profileImage"){
            alert.addAction(removeAction)
        }
        
        let cancelAction = UIAlertAction(title: "İptal", style: .cancel, handler: nil)
                
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
          
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
                
        present(alert, animated: true, completion: nil)
        
    }
    
    private func showImagePicker(sourceType: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("Seçilen Kaynak tipi mevcut değil")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            homeView.profileImage.image = editedImage
            print("Görsel seçildi: \(editedImage)")
        } else if let originalImage = info[.originalImage] as? UIImage {
            print("Görsel seçildi: \(originalImage)")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(didTapSettingsButton))
        navigationItem.rightBarButtonItems = [settingsButton]
    }
        
    @objc func didTapSettingsButton(){
        let vc = ACSettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
