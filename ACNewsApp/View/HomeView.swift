//
//  HomeView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 6.07.2024.
//
//
//  KCHomePageView.swift
//  KratosCase
//
//  Created by Ezgi Karahan on 9.06.2024.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func logOutButtonTapped()
}

class HomeView: UIView {

    //MARK: -Properties
    weak var delegate : HomeViewDelegate?
    
    let titleLabel : UILabel = {
       let label = UILabel()
       label.text = "User Name"
        label.font = UIFont(name: "ChalkboardSE-Bold", size: 27.0)
        label.textColor = .red
        label.numberOfLines = 5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()
    
    
    //MARK: - Init:
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubviews(titleLabel, logOutButton)
        addConstraints()
    }
    
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    //MARK: -Functions
    @objc private func logOutButtonPressed(){
        delegate?.logOutButtonTapped()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
          
            logOutButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logOutButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
                       
            
        ])
    }

}
