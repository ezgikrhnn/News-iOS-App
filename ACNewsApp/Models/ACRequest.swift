//
//  ACRequest.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import Foundation

final class ACRequest {
    //hata yönetimi için geri çağırma fonksiyonu
    var onErrorOccurred: ((String) -> Void)?
    
    ///   - urlString: Haber API uç noktasının URL dizesi.
    ///   - completion: Veri alındıktan veya bir hata oluştuğunda çalıştırılacak geri çağırma.
    func performRequest(with urlString: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            onErrorOccurred?("Invalid URL")
            return
        }

        // urlden veri cekmek için bir task oluştur:
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //oluşan hatalar yönet
            if let error = error {
                DispatchQueue.main.async {
                    self.onErrorOccurred?("Error fetching news: \(error.localizedDescription)")
                }
                return
            }
            
            //geçerli verilerin olup olmadığını kontrol et
            guard let data = data, !data.isEmpty else {
                DispatchQueue.main.async {
                    self.onErrorOccurred?("No data received")
                }
                return
            }

            //json verilerini verilen modele dönüştür
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                completion(.success(newsResponse))

            } catch {
                //dönüştürme sırasında oluşan hataları yakala yönet:
                DispatchQueue.main.async {
                    self.onErrorOccurred?("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        task.resume() //ağ görevini başlat
    }
    
    func fetchNews(from date: Date, completion: @escaping (Result<[Article], Error>) -> Void) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            
            let urlString = "https://newsapi.org/v2/everything?q=news&from=\(dateString)&sortBy=publishedAt&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
            
            performRequest(with: urlString) { result in
                switch result {
                case .success(let newsResponse):
                    let filteredArticles = newsResponse.articles.filter { !$0.title.lowercased().contains("removed") }
                    completion(.success(filteredArticles))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}
