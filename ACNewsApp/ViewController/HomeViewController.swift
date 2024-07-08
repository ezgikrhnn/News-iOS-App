//
//  HomeViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 6.07.2024.
//

import UIKit

class HomeViewController: UIViewController, HomeViewDelegate{
    
    //MARK: -Properties
    private let homeView = HomeView()
    var userModel: UserModel?
    let viewModel : HomeViewModel
   
    //MARK: -Init
    init(userModel: UserModel) {
            self.userModel = userModel
            self.viewModel = HomeViewModel(userModel: userModel)
            super.init(nibName: nil, bundle: nil)
        }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    //MARK: -Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home Page"
        view.addSubview(homeView)
        addCostraints()
        
        if let userModel = userModel {
            homeView.titleLabel.text = "\(userModel.name) \(userModel.surname)"
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
        
    }
}
