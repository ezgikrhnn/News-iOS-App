//
//  SelectionViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 16.06.2024.
//

/*
 import UIKit

class CategorySelectionViewController: UIViewController, CategorySelectionViewDelegate {

    let categorySelectionView = CategorySelectionView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(categorySelectionView)
        addCostraints()
        categorySelectionView.delegate = self
       
    }
        
    func addCostraints(){
        categorySelectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                
                categorySelectionView.topAnchor.constraint(equalTo: view.topAnchor),
                categorySelectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                categorySelectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                categorySelectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    
    func cellTapped(category: String) {
        guard let tabBarController = self.tabBarController else {
            return
            print("tabbar hatalı")
        }
        
        tabBarController.selectedIndex = 0 // NEWS sekmesine geçiş yap
        if let newsVc = tabBarController.viewControllers?[0] as? ACNewsViewController {
            newsVc.filterNewsByCategory(category)
            print("sayfa geçişi oluyor")
        }
    }
   
}

*/
