//
//  ACFavsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

class SaveViewController: UIViewController, SaveViewDelegate {

    let saveView = SaveView()
    var viewModel: SaveViewViewModel = SaveViewViewModel() //reload anında hata cıkarttıgı için bu şekilde belirttim.
    
    var saves: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved News"
        customizeNavigationBar()
        view.backgroundColor = .systemBackground
        setupFavsView()
        reloadFavorites()
    }
    
    private func setupFavsView() {
        view.addSubview(saveView)
        saveView.translatesAutoresizingMaskIntoConstraints = false
        saveView.tableView.delegate = self
        saveView.tableView.dataSource = self
        saveView.delegate = self
        
        NSLayoutConstraint.activate([
            saveView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            saveView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            saveView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            saveView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            saveView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            reloadFavorites()
    }
    
    func reloadFavorites() {
        saves = SaveManager.shared.getAllSaves()
        saveView.tableView.reloadData()
    }
    
    func didSelectArticle(_ article: Article) {
           // Detay sayfasına geçiş yap
        let viewModel = ACNewsDetailsViewModel(article: article)
        let detailVC = ACNewsDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailVC, animated: true)
        print("Selected Article: \(article.title)")
    }
}

extension SaveViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return saves.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SaveTableViewCell.cellIdentifier, for: indexPath) as! SaveTableViewCell
        let article = saves[indexPath.row]
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
            let selectedArticle = saves[indexPath.row]
            didSelectArticle(selectedArticle)
    }
    
    //sola kaydırma ile silme işlemi:
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let article = saves[indexPath.row]
        //kaydır savemanagerdan kaldır. -> bu işlem yapılmazsa sadece hücre silinir, detay sayfada hala save olarak kalacaktır.
        SaveManager.shared.removeSave(article: article)
        //veri kaynağından veriyi kaldırıyorum
        saves.remove(at: indexPath.row)
        //tableviewden hucreyi siliyorum:
        tableView.deleteRows(at: [indexPath], with: .automatic)
       
        
    }
}
