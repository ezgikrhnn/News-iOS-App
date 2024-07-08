//
//  CreateAccountView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//

import UIKit

protocol CreateAccountViewDelegate: AnyObject {
    func cancelButtonTapped()
    func createAccountButtonTapped()
}

class CreateAccountView: UIView {

    //MARK: - Properties:
    weak var delegate : CreateAccountViewDelegate?
    
    let createLabel : UILabel = {
       let label = UILabel()
       label.text = "Create Account"
       label.textColor = .red
       label.font = UIFont(name: "ChalkboardSE-Bold", size: 35.0)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.font = UIFont.systemFont(ofSize: 20) // Font boyutu
        textField.setPaddingPoints(10)
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
        }()
    
    let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Surname"
        textField.font = UIFont.systemFont(ofSize: 20) // Font boyutu
        textField.setPaddingPoints(10)
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
    
    let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = UIColor(named: "yellowColor")
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        return button
        }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
        }()
    
    lazy var accountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, surnameTextField, emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Init:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(accountStackView)
        addSubviews(createAccountButton, cancelButton, createLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    //MARK: - Functions:
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            createLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            createLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            
            // Stack view ortalamak için
            accountStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            accountStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                       
                       
            //Text field'lar için genişlik ve yükseklik ayarlaması: bunlar olmadan stack viewde hizalanma olmaz.
            nameTextField.widthAnchor.constraint(equalTo: accountStackView.widthAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            surnameTextField.widthAnchor.constraint(equalTo: accountStackView.widthAnchor),
            surnameTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.widthAnchor.constraint(equalTo: accountStackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalTo: accountStackView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
                       
            //Create account butonu
            createAccountButton.topAnchor.constraint(equalTo: accountStackView.bottomAnchor, constant: 120),
            createAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
                       
            //Cancel butonu
            cancelButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 10),
            cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    //log in button
    @objc private func cancelButtonPressed() {
        delegate?.cancelButtonTapped()
    }
    
    //create one button
    @objc private func createAccountButtonPressed() {
        delegate?.createAccountButtonTapped()
    }
    
}

