//
//  CreateAccountPageViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//


import UIKit
import FirebaseAuth
import FirebaseFirestore

class CreateAccountViewController: UIViewController, CreateAccountViewDelegate {
  
    //MARK: -Properties
    let CAview = CreateAccountView()
    let viewModel : CreateAccountViewModelProtocol
      
    //MARK: -Init
    // Dependency Injection ile ViewModel geçirilmesi
    init(viewModel: CreateAccountViewModelProtocol) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Account Page"
        view.addSubview(CAview)
        view.backgroundColor = .green
        addCostraints()
    }
    
    func addCostraints(){
        CAview.delegate = self
        CAview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            CAview.topAnchor.constraint(equalTo: view.topAnchor),
            CAview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            CAview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            CAview.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func cancelButtonTapped() {
        let viewModel2 = LogInViewModel(auth: Auth.auth(), firestore: Firestore.firestore())
        let vc = LogInViewController(viewModel: viewModel2)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func createAccountButtonTapped() {
        guard let email = CAview.emailTextField.text?.lowercased(),
              let password = CAview.passwordTextField.text,
              let name = CAview.nameTextField.text,
              let surname = CAview.surnameTextField.text else {
            return
        }
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let userModel = UserModel(name: name, surname: surname, email: trimmedEmail, uid: "")
        
        viewModel.createAccount(with: userModel, password: password) { [weak self] (result: Result<UserModel, Error>) in
            switch result {
            case .success(let userModel):
                print("başarılı")
                DispatchQueue.main.async {
                    let vc = HomeViewController(userModel: userModel, authService: Auth.auth())
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                    print("Veri homepagee geçiş yaptı")
                }
            case .failure(let error):
                print("Kullanıcı oluşturma hatası: \(error.localizedDescription)")
            }
        }
    }
}
