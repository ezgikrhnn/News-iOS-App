//
//  ACRequest.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import Foundation

final class ACRequest {
    var onErrorOccurred: ((String) -> Void)?

    func performRequest(with urlString: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            onErrorOccurred?("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.onErrorOccurred?("Error fetching news: \(error.localizedDescription)")
                }
                return
            }

            guard let data = data, !data.isEmpty else {
                DispatchQueue.main.async {
                    self.onErrorOccurred?("No data received")
                }
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(newsResponse))

            } catch {
                DispatchQueue.main.async {
                    self.onErrorOccurred?("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
