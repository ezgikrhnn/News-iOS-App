//
//  ACNewsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

protocol ACNewsViewDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
    func didSearchForText(_ text: String)
}

class ACNewsView: UIView {

    weak var delegate: ACNewsViewDelegate?
    var articles: [Article] = []
  
    
    let hotNewsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hotnews2")
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let hotNewsButton: UIButton = {
        let button = UIButton(type: .system)
            button.setTitle("Read Now", for: .normal)
            button.setTitleColor(UIColor(named: "LightRed"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = 20
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
    
    // TableView
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ACNewsTableViewCell.self, forCellReuseIdentifier: ACNewsTableViewCell.cellIdentifier)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.separatorStyle = .singleLine
        table.separatorColor = UIColor(named: "Light0Red")
        table.backgroundColor = .systemBackground
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // SearchBar
        let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = "Search News"
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            return searchBar
        }()
    
    //MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(tableView, searchBar, hotNewsImage, hotNewsButton)
        setupConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()///closure
    
    
    // Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
                       
            hotNewsImage.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            hotNewsImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            hotNewsImage.widthAnchor.constraint(equalToConstant: 380), // Ekran genişliği kadar yap
            hotNewsImage.heightAnchor.constraint(equalToConstant: 150),
            
            hotNewsButton.topAnchor.constraint(equalTo: hotNewsImage.topAnchor, constant: 85),
            hotNewsButton.trailingAnchor.constraint(equalTo: hotNewsImage.trailingAnchor, constant: -30),
            hotNewsButton.widthAnchor.constraint(equalTo: hotNewsImage.widthAnchor, multiplier: 0.3),
            hotNewsButton.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: hotNewsImage.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

extension ACNewsView: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ACNewsTableViewCell.cellIdentifier, for: indexPath) as? ACNewsTableViewCell else {
            fatalError("Could not dequeue ACNewsTableViewCell")
        }
        let article = articles[indexPath.row]
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
        if indexPath.row < articles.count {
            let article = articles[indexPath.row]
            delegate?.didSelectArticle(article)
        }
    }
}

extension ACNewsView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           delegate?.didSearchForText(searchText)
    }
}
