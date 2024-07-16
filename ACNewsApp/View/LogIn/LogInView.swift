//
//  LogInView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//

import UIKit

protocol LogInViewDelegate : AnyObject {
    func logInButtonTapped()
    func createOneButtonTapped()
}

class LogInView: UIView {

    weak var delegate: LogInViewDelegate?
    
    //MARK: - Properties
   
    let welcomeBackLabel : UILabel = {
       let label = UILabel()
       label.text = "Welcome Back"
       label.textColor = UIColor(named: "yellowColor")
       label.font = .systemFont(ofSize: 25, weight: .heavy)
       label.numberOfLines = 1
       label.textAlignment = .center
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Address"
        textField.font = UIFont.systemFont(ofSize: 20) // Font boyutu
        textField.setPaddingPoints(10)
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        }()
        
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.setPaddingPoints(10)
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 15
        textField.isSecureTextEntry = true
        
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        eyeButton.contentMode = .center
                
        // Butona iç boşluk ekle
        eyeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        textField.rightView = eyeButton
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        }()
    
    let rememberLabel : UILabel = {
       let label = UILabel()
       label.text = "Remember Me"
       label.textColor = .gray
       label.font = UIFont(name: "ChalkboardSE-Bold", size: 15.0)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let forgotPasswordLabel : UILabel = {
       let label = UILabel()
       label.text = "Forgot Password?"
       label.textColor = UIColor(named: "yellowColor")
       label.font = .systemFont(ofSize: 16, weight: .medium)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "yellowColor")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        return button
        }()
    
    let haveAccountLabel : UILabel = {
       let label = UILabel()
       label.text = "Don't have an account?"
       label.textColor = .gray
       label.font = .systemFont(ofSize: 16, weight: .medium)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create one", for: .normal)
        button.setTitleColor(.systemYellow, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createOneButtonPressed), for: .touchUpInside)
        return button
        }()
    
    lazy var accountStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [haveAccountLabel, createAccountButton])
            stackView.axis = .horizontal
            stackView.spacing = 5
            stackView.alignment = .center
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
    }()
    
    //MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(welcomeBackLabel, emailTextField, passwordTextField, rememberLabel, forgotPasswordLabel, logInButton, accountStackView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    //MARK: -Functions
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            welcomeBackLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeBackLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            // Email text alanının konumu ve boyutu
            emailTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: topAnchor, constant: 180),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
                        
            // Şifre text alanının konumu ve boyutu
            passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 240),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            rememberLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            rememberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            
            forgotPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            forgotPasswordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 70),
            logInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.widthAnchor.constraint(equalToConstant: 350),
            
            accountStackView.topAnchor.constraint(equalTo: bottomAnchor, constant: -150),
            accountStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
    }
    
    //log in button
    @objc private func logInButtonPressed() {
            delegate?.logInButtonTapped()
    }
    
    //create one button
    @objc private func createOneButtonPressed() {
            delegate?.createOneButtonTapped()
        }
}

extension UITextField {
    func setPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}
