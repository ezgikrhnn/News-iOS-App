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
}
