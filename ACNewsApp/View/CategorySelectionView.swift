//
//  SelectionView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 16.06.2024.
//

import UIKit

protocol CategorySelectionViewDelegate: AnyObject {
    func cellTapped(category: String)
}

class CategorySelectionView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
    weak var delegate : CategorySelectionViewDelegate?
    
    let categories = ["General","Business", "Sports", "Technology", "Science", "Health", "Entertainment"]

    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome to ACNews"
        label.textColor = UIColor(named: "LightRed")
        label.font = UIFont(name: "ChalkboardSE-Bold", size: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let categoryCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10 // Satırlar arasındaki minimum boşluk
            layout.minimumInteritemSpacing = 10 // Aynı satır içindeki hücreler arasındaki minimum boşluk
        
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(CategorySelectionCollectionViewCell.self, forCellWithReuseIdentifier: CategorySelectionCollectionViewCell.cellIdentifier)
            collectionView.backgroundColor = .systemBackground
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
    
    //MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(categoryCollectionView)
        addConstraints()
        backgroundColor = .systemBackground
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            //welcomeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
           // welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryCollectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 90),
            categoryCollectionView.widthAnchor.constraint(equalToConstant: 380)
        ])
    }
    
    //MARK: -CollectionView functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategorySelectionCollectionViewCell.cellIdentifier, for: indexPath) as? CategorySelectionCollectionViewCell else {
            fatalError("errorlandın")
        }
        
        let category = categories[indexPath.row]
        cell.titleLabel.text = category
        cell.contentView.backgroundColor = .lightGray
        
        if indexPath.row == 0 {
            cell.categoryImage.image  = UIImage(named: "general")
        } else if indexPath.row == 1 {
            cell.categoryImage.image = UIImage(named: "business")
        } else if indexPath.row == 2 {
            cell.categoryImage.image = UIImage(named: "sports")
        } else if indexPath.row == 3 {
            cell.categoryImage.image = UIImage(named: "technology")
        } else if indexPath.row == 4 {
            cell.categoryImage.image = UIImage(named: "science")
        } else if indexPath.row == 5 {
            cell.categoryImage.image = UIImage(named: "health")
        } else if indexPath.row == 6 {
            cell.categoryImage.image = UIImage(named: "entertainment")
        }
       
        return cell
    }
    
    // MARK: - CollectionView Delegate
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCategory = categories[indexPath.item]
        print("Selected category: \(selectedCategory)")
        delegate?.cellTapped(category: selectedCategory)
    
    }
        
    // MARK: - CollectionView Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Her hücrenin boyutunu burada ayarlayabilirsiniz
        return CGSize(width: 90, height: 90)
    }
}
