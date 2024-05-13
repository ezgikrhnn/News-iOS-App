//
//  NewsService.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

/*

import Foundation

struct NewsService {
    
    func fetchArticles(from endpoint: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(NewsAPIResponse.self, from: data)
                if let articles = response.articles {
                    completion(.success(articles))
                } else {
                    completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error parsing articles"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
*/
