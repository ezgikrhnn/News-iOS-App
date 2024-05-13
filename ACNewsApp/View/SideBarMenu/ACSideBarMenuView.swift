//
//  ACSideBarMenuView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 12.05.2024.
//
/*
import UIKit

class ACSideBarMenuView: UIView {
    var onCountrySelected: ((String) -> Void)?

    private let tableView = UITableView()

    let countries = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il", "in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no", "nz", "ph","pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve", "za"]
    var viewModel = ACNewsViewViewModel()
    /*var countries: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
     */

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
}

extension ACSideBarMenuView: UITableViewDataSource, UITableViewDelegate {
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
*/
