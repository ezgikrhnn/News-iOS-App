//
//  ACNewsDetailsViewViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import Foundation

class ACNewsDetailsViewModel {

    // MARK: - Properties
    var article: Article
    
    var title: String? {
        return article.title
    }
    var description: String? {
        return article.description
    }
    var authorName: String? {
        return article.author
    }
    var imageUrl: String? {
        return article.urlToImage
    }
    var formattedPublishDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: article.publishedAt)
    }
    
    // Initializer
    init(article: Article) {
        self.article = article
    }
}
