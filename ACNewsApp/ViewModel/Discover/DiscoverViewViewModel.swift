//
//  DİscoverViewViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 21.06.2024.
//

import Foundation

class DiscoverViewViewModel: viewModelProtocol {
    
    func fetchTodaysNews(fromCountry country: String, category: String, requestService: ACRequest) {
        print("j")
    }
    
    var category: String = ""
    var articles: [Article] = []
    var onNewsUpdated: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?
    
    private let requestService = ACRequest()
    
    func fetchNews(fromCountry country: String, category: String) {
        fetchNews(fromCountry: country, category: category, requestService: requestService)
    }
    
    func searchNews(with query: String) {
        searchNews(with: query, requestService: requestService)
    }
}
