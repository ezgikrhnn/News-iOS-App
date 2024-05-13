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

   
    func searchNews(with query: String)
    func fetchNews(fromCountry country: String)
}

class ACNewsViewViewModel: ACNewsViewModelProtocol {
    
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
}


/*
 
/* func fetchNews() {
     let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
     performRequest(with: urlString) { result in
         switch result {
         case .success(let newsResponse):
             DispatchQueue.main.async {
                 self.articles = newsResponse.articles
                 self.onNewsUpdated?()
             }
         case .failure:
             break
         }
     }
 }
 */
 */


/*
 class ACNewsViewViewModel {
     
     var articles: [Article] = []
     var onNewsUpdated: (() -> Void)?
     var onErrorOccurred: ((String) -> Void)?
     
     
     func searchNews(with query: String) {
         let urlString = "https://newsapi.org/v2/everything?q=\(query)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
         
         guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
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
     
 
     func fetchCountryNews(fromCountry country: String) {
         let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
         
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
             
             guard let data = data, !data.isEmpty else {
                 DispatchQueue.main.async {
                     self?.onErrorOccurred?("No data received")
                     print("No data received from the server. Check API key and Network.")
                 }
                 return
             }
             
             // Log the raw JSON response to see what you are receiving
             print(String(data: data, encoding: .utf8) ?? "Invalid JSON data")
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
                     print("Error decoding JSON: \(error.localizedDescription)")
                 }
             }
         }
         task.resume()
     }
 }
*/


/* KISA PERFORMREQUEST FONKSİYONU İLE DENENMİŞ HALİ:
 //GENEL HTTP İSTEĞİ METODU
 private func performRequest(with urlString: String, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
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
 
 func searchNews(with query: String) {
     let urlString = "https://newsapi.org/v2/everything?q=\(query)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
     performRequest(with: urlString) { [weak self] result in
         switch result {
         case .success(let newsResponse):
             DispatchQueue.main.async {
                 self?.articles = newsResponse.articles
                 self?.onNewsUpdated?()
             }
         case .failure(let error):
             DispatchQueue.main.async {
                 self?.onErrorOccurred?("Search failed: \(error.localizedDescription)")
             }
         }
     }
 }
 
 func fetchNews(fromCountry country: String) {
     let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
     performRequest(with: urlString) { result in
         switch result {
         case .success(let newsResponse):
             DispatchQueue.main.async {
                 self.articles = newsResponse.articles
                 self.onNewsUpdated?()
             }
         case .failure:
             break
         }
     }
 }*/
