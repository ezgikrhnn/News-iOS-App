//
//  ACFavsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 11.05.2024.
//

import UIKit

protocol SaveViewDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

class SaveView: UIView {
    
    weak var delegate: SaveViewDelegate?
    
    // TableView
    let tableView: UITableView = {
        let table = UITableView()
        table.register(SaveTableViewCell.self, forCellReuseIdentifier: SaveTableViewCell.cellIdentifier)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        table.separatorStyle = .singleLine
        table.separatorColor = UIColor(named: "Light0Red")
        table.backgroundColor = .systemBackground
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    //MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        setupTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
