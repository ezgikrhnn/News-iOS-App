//
//  HotNewsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 24.06.2024.
//

import UIKit

class HotNewsViewController: UIViewController, HotNewsViewDelegate {
   
    let hotNewsView = HotNewsView()
    var viewModel: viewModelProtocol
    
    //depedency Injection
      init(viewModel: viewModelProtocol) {
          self.viewModel = viewModel
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Latest News"
        bindViewModel()
        addConstraints()
        // Today's news fetch işlemi
            viewModel.fetchTodaysNews(requestService: ACRequest())
        // Do any additional setup after loading the view.
    }
    
    private func addConstraints() {
        view.addSubview(hotNewsView)
        hotNewsView.translatesAutoresizingMaskIntoConstraints = false
        hotNewsView.delegate = self
        NSLayoutConstraint.activate([
           
            hotNewsView.topAnchor.constraint(equalTo: view.topAnchor),
            hotNewsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hotNewsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotNewsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel.onNewsUpdated = {
            print("News was successfully fetched. Total articles: \(self.viewModel.articles.count)")
            // Burada UI güncellemeleri, tableView güncellemesi
            DispatchQueue.main.async {
                self.hotNewsView.articles = self.viewModel.articles
               
            }
        }

        viewModel.onErrorOccurred = { error in
            print("An error occurred: \(error)")
            // Hata durumunda kullanıcıya bilgi
        }
    }

    //view delegate fonksiyonu
    func didSelectArticle(_ article: Article) {
        // Detay sayfasına geçiş yap
        let viewModel = ACNewsDetailsViewModel(article: article)
        let detailVC = ACNewsDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
        print("Selected Article: \(article.title)")
    }
    
}
