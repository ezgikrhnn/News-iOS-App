//
//  CategorySelectionCollectionViewCell.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 16.06.2024.
//

import UIKit

final class CategorySelectionCollectionViewCell : UICollectionViewCell {
    
    static let cellIdentifier = "CategoryCollectionViewCell"
    
    //IMAGEVIEW
    let categoryImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //LABEL
     let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .darkGray
        contentView.addSubviews(categoryImage, titleLabel)
        addConstraints()
        
        //setUpLayer()
       }
       
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    private func addConstraints(){
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowColor = UIColor.gray.cgColor
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
}
