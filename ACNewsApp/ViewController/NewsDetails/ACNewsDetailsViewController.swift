//
//  ACNewsDetailsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import UIKit
import SafariServices

class ACNewsDetailsViewController: UIViewController {

    //MARK: - Properties
    var viewModel: ACNewsDetailsViewModel!
    var newsView = ACNewsDetailsView()
    
    
    //MARK: -Init
    init(viewModel: ACNewsDetailsViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openSourceURL() {
        guard let url = URL(string: viewModel.sourceUrl) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(newsView)
        setUpNewsDetailsView()
        setupNavigationBar()
        addConstraints()
        setupButtonActions()
        
    }
    
    //Detay sayfadan çıkınca like button son halini korusun:
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
        
        // Navigation Bar'ı güncelleme
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
                print("News removed from favorites")
            } else {
                FavoritesManager.shared.addFavorite(article: viewModel.article)
                print("News added to favorites")
               
            }
            updateLikeButtonAppearance()
       }
       
    @objc private func didTapShareButton() {
           print("Share button tapped")
        guard let url = URL(string: viewModel.sourceUrl) else {
                print("Invalid URL")
                return
            }
        
        let paylasilacakOgeler = [url]
        // Aktivite görünüm kontrolörü
        let activityViewController = UIActivityViewController(activityItems: paylasilacakOgeler, applicationActivities: nil)
           // AGK'yi göster
        present(activityViewController, animated: true)
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
        newsView.contentLabel.text = viewModel.content
        newsView.loadImage(from: viewModel.imageUrl)
        newsView.titleLabel.text = viewModel.title
        newsView.authorNameLabel.text = viewModel.authorName
        newsView.publishDateLabel.text = viewModel.formattedPublishDate
       }
    
    //buttona tıklama
    func setupButtonActions() {
        newsView.viewSourceButton.addAction(UIAction { [weak self] _ in
                self?.openSourceURL()
            }, for: .touchUpInside)
        }
    
}
