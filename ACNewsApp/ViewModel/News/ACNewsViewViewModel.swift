//
//  ACNewsViewViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

//protocols dosyasında oluşturdugum NewsViewModelProtocolden extend ediyorum:
class ACNewsViewViewModel: viewModelProtocol {
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
