//
//  DiscoverViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 19.06.2024.
//



 import UIKit
 
 class DiscoverViewController: UIViewController, DiscoverViewDelegate{
 
 var viewModel = ACNewsViewViewModel()
 var viewModelPro: ACNewsViewModelProtocol
 public let newsView = DiscoverView() //view
 
 //depedency Injection
 init(viewModel: ACNewsViewModelProtocol) {
 self.viewModelPro = viewModel
 super.init(nibName: nil, bundle: nil)
 }
 
 required init?(coder: NSCoder) {
 fatalError("init(coder:) has not been implemented")
 }
 
 
 override func viewDidLoad() {
 super.viewDidLoad()
 title = "Discover"
 view.backgroundColor = .systemBackground
 navigationController?.navigationBar.prefersLargeTitles = false
 viewModel.fetchNews(fromCountry: "us") //sayfa yüklendiğinde abd haberlerini göstersin
 bindViewModel()
 addConstraints()
 }
 
 private func addConstraints() {
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
 self.newsView.tableView.reloadData()
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
 viewModel.fetchNews(fromCountry: "us")
 } else {
 viewModel.searchNews(with: text)
 }
 }
 }
 
