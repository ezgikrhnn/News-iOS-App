//
//  ACFavsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

class ACFavsViewController: UIViewController, ACFavsViewDelegate {

    
    let favsView = ACFavsView()
    var viewModel: ACFavsViewViewModel = ACFavsViewViewModel() //reload anında hata cıkarttıgı için bu şekilde belirttim.
    
    var favorites: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favs"
        view.backgroundColor = .systemBackground
        setupFavsView()
        reloadFavorites()
       
    }
    
    private func setupFavsView() {
        view.addSubview(favsView)
        favsView.translatesAutoresizingMaskIntoConstraints = false
        favsView.tableView.delegate = self
        favsView.tableView.dataSource = self
        favsView.delegate = self
        
        NSLayoutConstraint.activate([
            favsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            favsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            reloadFavorites()
        }
    
    func reloadFavorites() {
        favorites = FavoritesManager.shared.getAllFavorites()
        favsView.tableView.reloadData()
    }
    
    func didSelectArticle(_ article: Article) {
           // Detay sayfasına geçiş yap
        let viewModel = ACNewsDetailsViewModel(article: article)
        let detailVC = ACNewsDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
        print("Selected Article: \(article.title)")
    }
}

extension ACFavsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favorites.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ACFavsTableViewCell.cellIdentifier, for: indexPath) as! ACFavsTableViewCell
        let article = favorites[indexPath.row]
        cell.titleLabel.text = article.title
        cell.descriptionLabel.text = article.description
        if let urlString = article.urlToImage {
            cell.newsImage.loadImage(from: urlString)
        }
        return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //Hücre --> detailPage için gerekli
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedArticle = favorites[indexPath.row]
            didSelectArticle(selectedArticle)
    }
    
    
}
