//
//  SelectionViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 16.06.2024.
//

import UIKit

class SelectionViewController: UIViewController {

    let selectionView = CategorySelectionView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(selectionView)
        addCostraints()
       
    }
        
    func addCostraints(){
        selectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                
        selectionView.topAnchor.constraint(equalTo: view.topAnchor),
        selectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        selectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        selectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
   
}
