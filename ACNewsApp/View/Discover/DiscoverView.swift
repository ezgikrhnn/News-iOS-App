
import UIKit

protocol DiscoverViewDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
    func didSearchForText(_ text: String)
}

class DiscoverView: UIView {

    weak var delegate: DiscoverViewDelegate?
    var articles: [Article] = []
    
    
    // TableView
    let tableView: UITableView = {
        let table = UITableView()
        table.register(DiscoverTableViewCell.self, forCellReuseIdentifier: DiscoverTableViewCell.cellIdentifier)
        table.rowHeight = UITableView.automaticDimension
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
        addSubviews(tableView, searchBar)
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
                       
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

extension DiscoverView: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTableViewCell.cellIdentifier, for: indexPath) as? DiscoverTableViewCell else {
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

extension DiscoverView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           delegate?.didSearchForText(searchText)
    }
}

