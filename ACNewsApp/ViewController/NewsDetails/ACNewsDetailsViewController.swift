//
//  ACNewsDetailsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import UIKit

class ACNewsDetailsViewController: UIViewController {

    
    var article: Article
    var newsView = ACNewsDetailsView()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newsView)
        newsView.descriptionLabel.text = article.description
        newsView.loadImage(from: article.urlToImage)
        newsView.titleLabel.text = article.title
        setupNavigationBar()
        addConstraints()
    }
    
   
    private func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.red, // Başlık rengi kırmızı
            .font: UIFont.boldSystemFont(ofSize: 20) // Font büyüklüğü ve kalınlığı
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.red, // Large title rengi kırmızı
            .font: UIFont.boldSystemFont(ofSize: 34) // Large title font büyüklüğü ve kalınlığı
        ]
        // Navigation Bar'ın önceki ayarlarını güncelleme
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        // Like Button
        let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(didTapLikeButton))
        // Download Button
        let downloadButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didTapShareButton))
        
        navigationItem.rightBarButtonItems = [downloadButton, likeButton]
    }
    
    
    @objc private func didTapLikeButton() {
           // "Like" butonuna tıklandığında yapılacak işlemler
           print("Like button tapped")
       }
       
       @objc private func didTapShareButton() {
           // "Download" butonuna tıklandığında yapılacak işlemler
           print("Download button tapped")
       }
    
    
    func addConstraints(){
        newsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }
}
