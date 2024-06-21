//
//  LGNewsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

class ACNewsViewController: UIViewController, ACNewsViewDelegate, CategorySelectionViewDelegate {
 
    
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
        customizeNavigationBar()
        newsView.cateView.delegate = self 
    }
    
    private func setupNewsView() {
        
        view.addSubview(newsView)
        newsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
           // Detay sayfasına geçiş yap
        let viewModel = ACNewsDetailsViewModel(article: article)
        let detailVC = ACNewsDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
        print("Selected Article: \(article.title)")
    }
    
    // Search text change handling
    func didSearchForText(_ text: String) {
        print("Searching for: \(text)")
        if text.isEmpty {
            viewModel.fetchNews(fromCountry: "us", category: viewModel.category, requestService: ACRequest())
        } else {
            viewModel.searchNews(with: text)
        }
    }
    
    //category hucresine tıklandıgında:
    func didSelectCategory(category: String) { //string olarak tıklanan kategori ismi geldi : orneğin = sports
        print("fonksiyon içinde")
        // Mevcut viewModelPro'yu kullanarak DiscoverViewController'a geçiş yap
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



/*
 //Side menu için table view
 extension ACNewsViewController: UITableViewDataSource, UITableViewDelegate {
 // TableView DataSource and Delegate
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return countries.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
 cell.textLabel?.text = countries[indexPath.row].uppercased()
 cell.backgroundColor = UIColor(named: "LightGray")
 return cell
 }
 
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 let selectedCountry = countries[indexPath.row]
 viewModel.fetchNews(fromCountry: selectedCountry)
 menuButton.title = selectedCountry
 toggleSideMenu()
 }
 }
 
 */
