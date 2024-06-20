//
//  ACNewsViewViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import Foundation

protocol ACNewsViewModelProtocol {
    var articles: [Article] { get set }
    var onNewsUpdated: (() -> Void)? { get set }
    var onErrorOccurred: ((String) -> Void)? { get set }
    var category : String {get set}
   
    func searchNews(with query: String)
    func fetchNews(fromCountry country: String)
}

class ACNewsViewViewModel: ACNewsViewModelProtocol {
    
    var category: String = ""
    var articles: [Article] = []
    var onNewsUpdated: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?
    
    private let requestService = ACRequest()
   
    func searchNews(with query: String) {
        // Sorgu parametresinin URL için uygun şekilde encode edilmesi sağlanıyor
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            onErrorOccurred?("Query encoding failed")
            return
        }
        
        let urlString = "https://newsapi.org/v2/everything?q=\(queryEncoded)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
        
        requestService.performRequest(with: urlString) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                DispatchQueue.main.async {
                    self?.articles = newsResponse.articles
                    self?.onNewsUpdated?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorOccurred?("Failed to fetch news: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchNews(fromCountry country: String) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
        requestService.performRequest(with: urlString) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                DispatchQueue.main.async {
                    self?.articles = newsResponse.articles
                    self?.onNewsUpdated?()
                }
            case .failure:
                break
            }
        }
    }
    
    func fetchNews(fromCountry country: String, category: String) {
            let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
            requestService.performRequest(with: urlString) { [weak self] result in
                switch result {
                case .success(let newsResponse):
                    DispatchQueue.main.async {
                        self?.articles = newsResponse.articles
                        self?.onNewsUpdated?()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.onErrorOccurred?("Failed to fetch news: \(error.localizedDescription)")
                    }
                }
            }
        }
}

