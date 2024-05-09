//
//  ACNewsDetailsViewController.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import UIKit

class ACNewsDetailsViewController: UIViewController {

    
    var article: Article
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let titleLabel = UILabel()
        titleLabel.text = article.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    
    }
    

    
}
