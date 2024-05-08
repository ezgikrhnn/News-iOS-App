//
//  ACArticle.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import Foundation

struct Article {
    let source: Source
    let author: String?  //optional yani nil olabilir.
    let title: String
    let url: String
    let publishedAt: Date
    let description: String?
    let urlToImage: String?
    
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

extension Article: Codable {}  // hem decode hem encode yapılabilir
extension Article: Equatable {}
extension Article: Identifiable {
    var id: String {url}
}

extension Source: Codable{}
extension Source: Equatable {}

extension Article {
    static var previewData: [Article]{
        let previewDataURL = Bundle.main.url(forResource: "news", withExtension: "json")
    }
}
