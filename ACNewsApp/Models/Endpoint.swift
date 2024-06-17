//
//  Endpoint.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 16.06.2024.
//

/**Burada edpoint tanımlanmıştır.
 Bu enum, üç farklı case (everything, topHeadlines, sources) ile tanımlanmıştır:

 1. Endpoint
    - everything: Herhangi bir sorguya göre (query), tarih aralığına, dil ve sıralama kriterlerine göre arama yapmayı sağlar.
    - topHeadlines: Ülke, kategori veya kaynaklara göre en üst başlıkları almayı sağlar.
    - sources: Haber kaynaklarını listelemeyi sağlar.

 2. urlString Özellik:
    Her bir case için urlString adında bir computed property tanımlanmıştır. Bu property, o case'e göre oluşturulan URL'yi döndürür.
    - Base URL: Haber API'sinin ana URL'i (baseURL) tanımlanmıştır.
    - API Key: API erişimi için gereken API anahtarı (apiKey) burada sabit olarak tanımlanmıştır. Gerçek projede, bu anahtar güvenlik nedenleriyle güvenli bir şekilde saklanmalıdır.
    - URLComponents: URLComponents sınıfı, URL'nin bileşenlerini (scheme, host, path, query items vb.) kolayca yönetmemizi sağlar.
    - Query Items: Her case için gerekli olan query parametreleri (URLQueryItem) tanımlanır ve urlComponents.queryItems üzerine eklenir.
    - Absolute String: urlComponents.url!.absoluteString ile tam URL string'i döndürülür.


 **/

import Foundation

enum Endpoint {
    case everything(query: String, fromDate: String?, toDate: String?, language: String, sortBy: String)
    case topHeadlines(country: String?, category: String?, sources: String?)
    case sources

    var urlString: String {
        let baseURL = "https://newsapi.org/v2/"
        let apiKey = "YOUR_NEWS_API_KEY"
        
        switch self {
        case .everything(let query, let fromDate, let toDate, let language, let sortBy):
            var urlComponents = URLComponents(string: baseURL + "everything")!
            var queryItems = [
                URLQueryItem(name: "q", value: query),
                URLQueryItem(name: "apiKey", value: apiKey),
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "sortBy", value: sortBy)
            ]
            
            if let fromDate = fromDate {
                queryItems.append(URLQueryItem(name: "from", value: fromDate))
            }
            if let toDate = toDate {
                queryItems.append(URLQueryItem(name: "to", value: toDate))
            }
            
            urlComponents.queryItems = queryItems
            return urlComponents.url!.absoluteString

        case .topHeadlines(let country, let category, let sources):
            var urlComponents = URLComponents(string: baseURL + "top-headlines")!
            var queryItems = [URLQueryItem(name: "apiKey", value: apiKey)]
            
            if let country = country {
                queryItems.append(URLQueryItem(name: "country", value: country))
            }
            if let category = category {
                queryItems.append(URLQueryItem(name: "category", value: category))
            }
            if let sources = sources {
                queryItems.append(URLQueryItem(name: "sources", value: sources))
            }
            
            urlComponents.queryItems = queryItems
            return urlComponents.url!.absoluteString

        case .sources:
            return baseURL + "top-headlines/sources?apiKey=\(apiKey)"
        }
    }
}
