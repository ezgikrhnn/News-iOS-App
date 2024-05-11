//
//  ACNewsDetailsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import UIKit

class ACNewsDetailsViewController: UIViewController {

    //MARK: - Properties
    var viewModel: ACNewsDetailsViewModel!
    var newsView = ACNewsDetailsView()
    
    init(viewModel: ACNewsDetailsViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newsView)
        setUpNewsDetailsView()
        setupNavigationBar()
        addConstraints()
    }
    
    //sayfadan çıkınca kalp eski haline dönmesin güncel kalsın diye
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            updateLikeButtonAppearance()
        }
    
    //MARK: -Functions
    private func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.red,
            .font: UIFont.boldSystemFont(ofSize: 34)
        ]
        // Navigation Bar'ın önceki ayarlarını güncelleme
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        // Like Button
        let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(didTapLikeButton))
        // Download Button
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didTapShareButton))
        
        navigationItem.rightBarButtonItems = [shareButton, likeButton]
    }
    
    @objc private func didTapLikeButton() {
        if FavoritesManager.shared.isFavorite(article: viewModel.article) {
                FavoritesManager.shared.removeFavorite(article: viewModel.article)
                print("Article removed from favorites")
            } else {
                FavoritesManager.shared.addFavorite(article: viewModel.article)
                print("Article added to favorites")
               
            }
            updateLikeButtonAppearance()
       }
       
    @objc private func didTapShareButton() {
           print("Download button tapped")
       }
    
    private func updateLikeButtonAppearance() {
        let isFavorite = FavoritesManager.shared.isFavorite(article: viewModel.article)
        let imageName = isFavorite ? "heart.fill" : "heart"
        navigationItem.rightBarButtonItems?[1].image = UIImage(systemName: imageName)
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
    
    private func setUpNewsDetailsView(){
        newsView.descriptionLabel.text = viewModel.description
        newsView.loadImage(from: viewModel.imageUrl)
        newsView.titleLabel.text = viewModel.title
        newsView.authorNameLabel.text = viewModel.authorName
        newsView.publishDateLabel.text = viewModel.formattedPublishDate
       }
}
