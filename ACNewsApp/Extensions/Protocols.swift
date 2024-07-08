//
//  Protocols.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 21.06.2024.
//

//burada discover ve news sayfasında search ve fetch işlemleri için bir protocol oluşturuyorum

import Foundation

protocol viewModelProtocol: AnyObject{
    var articles: [Article] { get set }
    var onNewsUpdated: (() -> Void)? { get set }
    var onErrorOccurred: ((String) -> Void)? { get set }
    var category: String { get set }

    func fetchNews(fromCountry country: String, category: String)
    func searchNews(with query: String)
    func fetchTodaysNews(requestService: ACRequest)
    
}

extension viewModelProtocol {
    func fetchNews(fromCountry country: String, category: String, requestService: ACRequest) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
        requestService.performRequest(with: urlString) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                DispatchQueue.main.async {
                    self?.articles = newsResponse.articles.filter{$0.title.lowercased().contains("removed") == false} //içeriği removed olan haberler listelensin istemiyorum.
                    self?.onNewsUpdated?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorOccurred?("Failed to fetch news: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func searchNews(with query: String, requestService: ACRequest) {
        guard let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            onErrorOccurred?("Query encoding failed")
            return
        }
        
        let urlString = "https://newsapi.org/v2/everything?q=\(queryEncoded)&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
        requestService.performRequest(with: urlString) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                DispatchQueue.main.async {
                    self?.articles = newsResponse.articles.filter{$0.title.lowercased().contains("removed") == false} //içeriği removed olan haberler listelensin istemiyorum.
                    self?.onNewsUpdated?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorOccurred?("Failed to fetch news: \(error.localizedDescription)")
                }
            }
        }
    }
   
    //hotnewstoday için fetch fonksiyonu,"apıden haberler 1 gün sonra guncellendiği için en yeni haberler 1 gun oncesine ait"
    func fetchTodaysNews(requestService: ACRequest) {
            let today = Date() 
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: today)
            
            let startOfDay = Calendar.current.startOfDay(for: today)
            let endOfDay = Calendar.current.date(byAdding: .day, value: -1, to: startOfDay)!
            
            let startOfDayString = ISO8601DateFormatter().string(from: startOfDay)
            let endOfDayString = ISO8601DateFormatter().string(from: endOfDay)
            
            let urlString = "https://newsapi.org/v2/everything?q=tesla&from=\(startOfDayString)&to=\(endOfDayString)&sortBy=publishedAt&apiKey=aa866dd109b4435aa11ab4640bb06bf3"
            
            requestService.performRequest(with: urlString) { [weak self] result in
            switch result {
            case .success(let newsResponse):
                DispatchQueue.main.async {
                    self?.articles = newsResponse.articles.filter{$0.title.lowercased().contains("removed") == false} //içeriği removed olan haberler listelensin istemiyorum.
                    self?.onNewsUpdated?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.onErrorOccurred?("Failed to fetch today's news: \(error.localizedDescription)")
                }
            }
        }
    }
}
