//
//  ACFavsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 11.05.2024.
//

import UIKit

protocol ACFavsViewDelegate: AnyObject {
    func didSelectArticle(_ article: Article)
}

class ACFavsView: UIView {
    
    weak var delegate: ACFavsViewDelegate?
    
    // TableView
    let tableView: UITableView = {
        let table = UITableView()
        table.register(ACFavsTableViewCell.self, forCellReuseIdentifier: ACFavsTableViewCell.cellIdentifier)
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


    
/*/
extension ACFavsView: UITableViewDelegate, UITableViewDataSource{
       
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ACFavsTableViewCell.cellIdentifier, for: indexPath) as? ACNewsTableViewCell else {
                fatalError("Could not dequeue ACNewsTableViewCell")
            }
            return cell
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
    }

*/
