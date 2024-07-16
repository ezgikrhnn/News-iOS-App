//
//  LGNewsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

class ACNewsViewController: UIViewController, ACNewsViewDelegate, CategorySelectionViewDelegate {
  
    var newsViewModel = ACNewsViewViewModel()
    var viewModel: viewModelProtocol
    public let newsView = ACNewsView() //view
    let menuButton = UIBarButtonItem()
    let sideMenuView = UIView()
    
   // let countries = ["ae", "ar", "at", "au", "be", "br", "ca", "cn", "co", "cu", "cz", "de", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr","ma", "mx", "my", "ng", "nl", "no", "nz", "ph","pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
 
    //Dependency Injection
    init(viewModel: viewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        viewModel.fetchNews(fromCountry: "us", category: viewModel.category, requestService: ACRequest()) //sayfa yüklendiğinde abd haberlerini göstersin
        
        bindViewModel()
        setupNewsView()
     
        newsView.cateView.delegate = self
        
        //NotificationCenter.default.addObserver(self, selector: #selector(handleSaveManagerUpdate), name: .didUpdateSavedArticles, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            reloadSaves()
    }
    
      func reloadSaves() {
          newsView.newsCollectionView.reloadData()
    }
  
    private func setupNewsView() {
        
        view.addSubview(newsView)
        newsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
          
            newsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            newsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        newsView.delegate = self
    }
    
    func bindViewModel() {
        viewModel.onNewsUpdated = {
            print("News was successfully fetched. Total articles: \(self.viewModel.articles.count)")
            // Burada UI güncellemeleri, tableView güncellemesi
            DispatchQueue.main.async {
                self.newsView.articles = self.viewModel.articles
                self.newsView.newsCollectionView.reloadData() 
            }
        }
        viewModel.onErrorOccurred = { error in
            print("An error occurred: \(error)")
            // Hata durumunda kullanıcıya bilgi
        }
    }
    
    //view delegate fonksiyonu
    func didSelectArticle(_ article: Article) {
           // Detay sayfasına geçiş
        let viewModel = ACNewsDetailsViewModel(article: article)
        let detailVC = ACNewsDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
        print("Selected Article: \(article.title)")
    }
    
    func didSearchForText(_ text: String) {
        
        print("Searching for: \(text)")
        if text.isEmpty {
            viewModel.fetchNews(fromCountry: "us", category: viewModel.category, requestService: ACRequest())
        } else {
            viewModel.searchNews(with: text)
        }
    }
    
    func didTapHotNewsButton() {
        //discoverViewControllera geçiş
       
        let vc = HotNewsViewController(viewModel: viewModel)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //category hucresine tıklandıgında:
    func didSelectCategory(category: String) { //string olarak tıklanan kategori ismi geldi : orneğin = sports
        print("fonksiyon içinde")
        
        viewModel.category = category
        
        let discoverViewModel = DiscoverViewViewModel()
        discoverViewModel.category = category
        let discoverVC = DiscoverViewController(viewModel: discoverViewModel, category: category)
        navigationController?.pushViewController(discoverVC, animated: true)
        print("DiscoverViewController'a geçiş yapıldı. Seçilen kategori: \(category)")
    }
    
    func filterNewsByCategory(_ category: String) {
            print("Filtering news by category: \(category)")
            viewModel.searchNews(with: category)
    }
}

