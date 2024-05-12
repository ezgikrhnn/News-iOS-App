//
//  LGNewsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

class ACNewsViewController: UIViewController, ACNewsViewDelegate{
    
    
    var viewModel = ACNewsViewViewModel()
    public let newsView = ACNewsView() //view
    let menuButton = UIBarButtonItem()
    let sideMenuView = UIView()
    let tableView = UITableView()
    let countries = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph","pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
 // Ülke kodlarınız
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AppCent News"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        viewModel.fetchNews()
        bindViewModel()
        setupNewsView()
      
        //sayfa yüklendiğinde abd haberlerini göstersin
        setupNavigationBar()
        setupSideMenu()
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
            // Burada UI güncellemeleri yapabilirsiniz, örneğin bir tableView güncellemesi
            DispatchQueue.main.async {
                self.newsView.articles = self.viewModel.articles
                self.newsView.tableView.reloadData() 
            }
        }
        
        viewModel.onErrorOccurred = { error in
            print("An error occurred: \(error)")
            // Hata durumunda kullanıcıya bilgi verebilirsiniz
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
            viewModel.fetchNews()
        } else {
            viewModel.searchNews(with: text)
        }
    }
    
    func setupNavigationBar() {
        menuButton.title = "Countries"
        menuButton.target = self
        menuButton.tintColor = UIColor(named: "LightRed")
        menuButton.action = #selector(toggleSideMenu)
        navigationItem.leftBarButtonItem = menuButton
    }

    func setupSideMenu() {
            sideMenuView.frame = CGRect(x: -200, y: 0, width: 200, height: self.view.frame.height)
            sideMenuView.backgroundColor = .white
            self.view.addSubview(sideMenuView)

            tableView.frame = sideMenuView.bounds
            tableView.delegate = self
            tableView.dataSource = self
            sideMenuView.addSubview(tableView)
        }

        @objc func toggleSideMenu() {
            UIView.animate(withDuration: 0.3) {
                self.sideMenuView.frame.origin.x = self.sideMenuView.frame.origin.x == 0 ? -200 : 0
            }
        }
}

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
        viewModel.fetchCountryNews(fromCountry: selectedCountry)
        toggleSideMenu()
    }
}


/*
extension ACNewsViewController: UITableViewDelegate, UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.articles.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ACNewsTableViewCell.cellIdentifier, for: indexPath) as? ACNewsTableViewCell else {
                fatalError("Could not dequeue ACNewsTableViewCell")
            }
            let article = viewModel.articles[indexPath.row]
            cell.titleLabel.text = article.title
            cell.descriptionLabel.text = article.description
            cell.loadImage(from: article.urlToImage)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
*/
