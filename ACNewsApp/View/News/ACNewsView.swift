//
//  ACNewsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

protocol ACNewsViewDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

class ACNewsView: UIView {

   /** // Example Data
        var articles = [
            Article(source: Source(id: "", name: "Test Source"), author: "Author Name", title: "DENEME", description: "This is a test description", url: "https://example.com", urlToImage: "https://www.example.com/image.jpg", publishedAt: Date())
        ]
    */

    weak var delegate: ACNewsViewDelegate?
    var articles: [Article] = []
    
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

    
    // Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        setupConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] ///bu satır sayesinde imageView'in sadece üst 2 köşesine cornerRadius uygulandı.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()///closure
    
    
    // Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

//viewcontrollerde tableview fonksiyonları olmasına ragmen yeniden yazıyorum bu, bu viewin baska bir controllerda da kullanılması durumunda o controllera fonksiyonunu bildirmesi için lazımdır.

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
/*
extension ACNewsView: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 20
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // veya diğer hesaplamalar
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ACNewsTableViewCell.cellIdentifier, for: indexPath) as? ACNewsTableViewCell else {
                fatalError("Could not dequeue ACNewsTableViewCell")
            }
        
        // Dizi sınırlarını aşmamak için güvenli bir şekilde eleman alalım
            if indexPath.row < articles.count {
                let article = articles[indexPath.row]
                cell.titleLabel.text = article.title
                if let imageUrlString = article.urlToImage, let imageUrl = URL(string: imageUrlString) {
                    // Resim yüklemek için URLSession kullanılabilir veya bir resim yükleme kütüphanesi (örn. SDWebImage)
                    URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                        if let data = data {
                            DispatchQueue.main.async {
                                cell.newsImage.image = UIImage(data: data)
                            }
                        }
                    }.resume()
                } else {
                    cell.newsImage.image = UIImage(systemName: "magnifyingglass")  // Eğer resim URL'si yoksa varsayılan bir resim göster
                }
            }
            
            
           // cell.titleLabel.text = "deneme"
           // cell.newsImage.image = UIImage(systemName: "magnifyingglass") // For demonstration, using system image
            return cell
    }

    // MARK: UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
}


*/

