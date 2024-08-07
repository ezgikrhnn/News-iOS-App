//
//  LogInViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LogInViewController: UIViewController, LogInViewDelegate {

    //MARK: -Properties
    let logInView = LogInView()
    let viewModel : LogInViewModelProtocol
    var userModel : UserModel?
    
    //MARK: -Init
    //dependency Injection için constructor
    init(viewModel: LogInViewModelProtocol){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        logInView.delegate = self //delegate
        view.addSubview(logInView)
        view.backgroundColor = .systemBackground
        addCostraints()
    }
    
    func addCostraints(){
        logInView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            logInView.topAnchor.constraint(equalTo: view.topAnchor),
            logInView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            logInView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
  

    private func showTabBarController(with userModel: UserModel) {
        DispatchQueue.main.async {
            let tabBarController = ACTabbarViewController(userModel: userModel)
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true, completion: nil)
        }
    }

    func logInButtonTapped() {
        guard let email = logInView.emailTextField.text?.lowercased(),
              let password = logInView.passwordTextField.text else {
            showAlert(title: "Error", message: "Invalid user name or password")
            return
        }
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        viewModel.loginUser(email: trimmedEmail, password: password) { [weak self] result in
            switch result {
            case .success(let userModel):
                DispatchQueue.main.async {
                    self?.userModel = userModel // Store the userModel temporarily
                    print("UserModel in HomeViewController:")
                    print("Name: \(userModel.name)")
                    print("Surname: \(userModel.surname)")
                    print("Email: \(userModel.email)")
                }
            case .failure(let error):
                print("Oturum açma Hatası: \(error.localizedDescription)")
                self?.showAlert(title: "Login Error", message: "Invalid user name or password")
            }
        }
    }

    func createOneButtonTapped() {
        let viewModel = CreateAccountViewModel(auth: Auth.auth(), firestore: Firestore.firestore())
        let vc = CreateAccountViewController(viewModel: viewModel)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
