import UIKit

protocol HotNewsViewDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}


class HotNewsView: UIView {

    weak var delegate: HotNewsViewDelegate?
    var articles: [Article] = [] {
            didSet {
                tableView.reloadData()
            }
        }
        
    // TableView
    let tableView: UITableView = {
        let table = UITableView()
        table.register(HotNewsTableViewCell.self, forCellReuseIdentifier: HotNewsTableViewCell.cellIdentifier)
        table.rowHeight = UITableView.automaticDimension
        table.separatorStyle = .singleLine
        table.separatorColor = UIColor(named: "Light0Red")
        table.backgroundColor = .systemBackground
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(tableView)
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

extension HotNewsView: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HotNewsTableViewCell.cellIdentifier, for: indexPath) as? HotNewsTableViewCell else {
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


