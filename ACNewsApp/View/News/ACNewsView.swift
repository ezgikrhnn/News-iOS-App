//
//  ACNewsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

protocol ACNewsViewDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
    func didSearchForText(_ text: String)
}

class ACNewsView: UIView {

    weak var delegate: ACNewsViewDelegate?
    var articles: [Article] = []
    let cateView = CategorySelectionView()

    let hotNewsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hotnews2")
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let hotNewsButton: UIButton = {
        let button = UIButton(type: .system)
            button.setTitle("Read Now", for: .normal)
            button.setTitleColor(UIColor(named: "LightRed"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
    let newsCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 10 // Satırlar arasındaki minimum boşluk
            layout.minimumInteritemSpacing = 10 // Aynı satır içindeki hücreler arasındaki minimum boşluk
        
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(ACNewsCollectionViewCell.self, forCellWithReuseIdentifier: ACNewsCollectionViewCell.cellIdentifier)
            collectionView.backgroundColor = .systemBackground
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()

    // SearchBar
        let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = "Search News"
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            return searchBar
        }()
    
    //MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(newsCollectionView, searchBar, hotNewsImage, hotNewsButton, cateView.categoryCollectionView)
        setupConstraints()
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()///closure
    
    // Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
                       
            hotNewsImage.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            hotNewsImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            hotNewsImage.widthAnchor.constraint(equalToConstant: 380), // Ekran genişliği kadar yap
            hotNewsImage.heightAnchor.constraint(equalToConstant: 150),
            
            hotNewsButton.topAnchor.constraint(equalTo: hotNewsImage.topAnchor, constant: 85),
            hotNewsButton.trailingAnchor.constraint(equalTo: hotNewsImage.trailingAnchor, constant: -30),
            hotNewsButton.widthAnchor.constraint(equalTo: hotNewsImage.widthAnchor, multiplier: 0.3),
            hotNewsButton.heightAnchor.constraint(equalToConstant: 40),
            
            newsCollectionView.topAnchor.constraint(equalTo: hotNewsImage.bottomAnchor, constant: 10),
            newsCollectionView.heightAnchor.constraint(equalToConstant: 260),
            newsCollectionView.widthAnchor.constraint(equalToConstant: 380),
            newsCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
        
            
            cateView.categoryCollectionView.topAnchor.constraint(equalTo: newsCollectionView.bottomAnchor, constant: 20),
            cateView.categoryCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension ACNewsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ACNewsCollectionViewCell.cellIdentifier, for: indexPath) as? ACNewsCollectionViewCell else {
            fatalError("Could not dequeue ACNewsTableViewCell")
        }
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        //cell.descriptionLabel.text = article.description
        cell.loadImage(from: article.urlToImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < articles.count{
            let article = articles[indexPath.row]
            delegate?.didSelectArticle(article)
        }
    }
    // MARK: - CollectionView Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250) //hücre boyutu
    }
}

extension ACNewsView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           delegate?.didSearchForText(searchText)
    }
}

