//
//  HomePageView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 4.07.2024.
//

import UIKit

protocol HomePageViewDelegate: AnyObject {
    func logOutButtonTapped()
    func sendNewsButtonTapped()
    func editProfileImageButtonTapped()
}

class HomePageView: UIView {

    //MARK: -Properties
    weak var delegate : HomePageViewDelegate?
    
    let profileImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = UIColor(named: "LightRed")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel : UILabel = {
       let label = UILabel()
       label.text = "User Name"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var locationLabel : UILabel = {
       let label = UILabel()
       label.text = "Istanbul, Turkey"
        label.textColor = .gray
        label.font = UIFont(name: "Arial", size: 14.0)
        label.numberOfLines = 5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconPeopleImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "people")
        imageView.tintColor = UIColor(named: "LightRed")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    var newsLabel : UILabel = {
       let label = UILabel()
       label.text = "Is there any news around you?"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "square.and.pencil")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.addTarget(self, action: #selector(editProfileImageButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()
  
    
    let sendNewsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Send it Now!", for: .normal)
        button.backgroundColor = UIColor(named: "LightRed")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15

        // Gölge eklemek için
        // Buton içeriği etrafındaki boşluğu ayarlamak için
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(sendNewsButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let locationImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emailImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "envelope")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var emailLabel : UILabel = {
       let label = UILabel()
       label.text = "karahanezgi64@gmail.com"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init:
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews(profileImage, titleLabel, editProfileButton, locationLabel,locationImage, logOutButton, iconPeopleImage, sendNewsButton, newsLabel, emailImage, emailLabel)
        addConstraints()
      
        
    }
    
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    //MARK: -Functions
    @objc private func logOutButtonPressed(){
        delegate?.logOutButtonTapped()
    }
    
    @objc private func sendNewsButtonPressed(){
        delegate?.sendNewsButtonTapped()
    }
    
    @objc private func editProfileImageButtonPressed(){
        delegate?.editProfileImageButtonTapped()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImage.heightAnchor.constraint(equalToConstant: 130),
            profileImage.widthAnchor.constraint(equalToConstant: 130),
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            editProfileButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -30),
            editProfileButton.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -25),
            titleLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120),
           
            locationImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            locationImage.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: 8),
            
            emailImage.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            emailImage.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 20),
            emailLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 12),
            emailLabel.leadingAnchor.constraint(equalTo: emailImage.trailingAnchor, constant: 8),
            
            newsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            newsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            sendNewsButton.topAnchor.constraint(equalTo: newsLabel.bottomAnchor, constant: 20),
            sendNewsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            iconPeopleImage.topAnchor.constraint(equalTo: newsLabel.bottomAnchor, constant: 30 ),
            iconPeopleImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            iconPeopleImage.heightAnchor.constraint(equalToConstant: 200),
            iconPeopleImage.widthAnchor.constraint(equalToConstant: 200),
            
            logOutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
            logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logOutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

}
