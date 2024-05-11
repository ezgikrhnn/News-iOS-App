//
//  ACNewsViewViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import Foundation

class ACNewsViewViewModel {
    var articles: [Article] = []
    var onNewsUpdated: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?

    func fetchNews() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
        guard let url = URL(string: urlString) else {
            onErrorOccurred?("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.onErrorOccurred?("Error fetching news: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onErrorOccurred?("No data received")
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.articles = newsResponse.articles
                    self?.onNewsUpdated?()
                }
            } catch {
                DispatchQueue.main.async {
                    self?.onErrorOccurred?("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }

        task.resume()
    }
}

