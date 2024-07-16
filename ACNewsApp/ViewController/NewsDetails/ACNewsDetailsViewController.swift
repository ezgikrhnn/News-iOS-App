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
            updateSaveButtonAppearance()
    }
    
    //MARK: -Functions
    
    private func setupNavigationBar() {
        
        // Like Button
        let saveButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(didTapSaveButton))
        // Download Button
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didTapShareButton))
        
        navigationItem.rightBarButtonItems = [shareButton, saveButton]
    }
    
    //updateSaveButton() fonksiyonunu bookmarka tıklandıgında calışması için burada çağırıyorum:
    @objc private func didTapSaveButton() {
        if SaveManager.shared.isSave(article: viewModel.article) {
            SaveManager.shared.removeSave(article: viewModel.article)
                print("News removed from favorites")
            } else {
                SaveManager.shared.addSave(article: viewModel.article)
                print("News added to favorites")
               
            }
            updateSaveButtonAppearance()
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
    
    //SaveManagerin isSave değerine göre bookmark dolduran fonksiyon
    private func updateSaveButtonAppearance() {
        let isSave = SaveManager.shared.isSave(article: viewModel.article) //url değerine göre isSave true ya da false
        let imageName = isSave ? "bookmark.fill" : "bookmark"  //true ise bookmark içi dolu
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
