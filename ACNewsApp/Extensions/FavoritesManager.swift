//
//  FavoritesManager.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 11.05.2024.
//

import Foundation
//id ile değil url ile benzersiz bir id varmış gibi yaptım. çünkü article sınıfının doğrudan bir id özelliği yok

class FavoritesManager {
    static let shared = FavoritesManager()
    private(set) var favorites: [Article] = []

    func addFavorite(article: Article) {
        if !favorites.contains(where: { $0.url == article.url }) {
            favorites.append(article)
        }
    }
    
    func removeFavorite(article: Article) {
        favorites.removeAll(where: { $0.url == article.url })
    }
    
    func isFavorite(article: Article) -> Bool {
        return favorites.contains(where: { $0.url == article.url })
    }
    
    func getAllFavorites() -> [Article] {
           return favorites
       }
}
