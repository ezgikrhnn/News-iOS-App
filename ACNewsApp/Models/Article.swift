//
//  ACArticle.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

/*import Foundation
 
 struct Article : Codable {
 let source: Source
 let author: String?  //optional yani nil olabilir.
 let title: String
 let description: String?
 let url: String
 let urlToImage: String?
 let publishedAt: Date
 
 
 
 
 var authorText: String {
 author ?? ""
 }
 
 var descriptionText: String{
 description ?? ""
 }
 
 var articleURL: URL{
 URL(string: url)!
 }
 
 var imageURL: URL? {
 guard let urlToImage = urlToImage else {
 return nil
 }
 return URL(string: urlToImage)
 }
 }
 
 struct Source {
 //no need for source id
 let name: String
 }
 
 // hem decode hem encode yapılabilir
 extension Article: Equatable {}
 extension Article: Identifiable {
 var id: String {url}
 }
 
 extension Source: Codable{}
 extension Source: Equatable {}
 
 extension Article {
 static var previewData: [Article]{
 
 let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")!  //neden unwrapping var araştır.
 let data = try! Data(contentsOf: previewDataURL)
 let jsonDecoder = JSONDecoder()
 jsonDecoder.dateDecodingStrategy = .iso8601  //araştır
 
 let apiResponse = try! jsonDecoder.decode(NewsAPIResponse.self, from: data)
 
 return apiResponse.articles ?? []
 }
 }
 */

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date
}

struct Source: Codable {
    let id: String?
    let name: String
}
