//
//  FavoritesManager.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 11.05.2024.
//


/*
 SINIF AÇIKLAMASI:
 Bu sınıftan Singleton tasarım deseni kullanılmıştır. 'shared' propertisi ile sınıfın tek bir örneği oluşturuldu ve daha sonra kullanılır. (bütünlüğü korur)

 favorites --> private(set) erişim kontrolü ile dışarıdan bu listeye sadece okunabilir (get) ama değiştirilemez (set). Yani bu liste yalnızca FavoritesManager içindeki metotlar tarafından değiştirilebilir.
 
 
 **/
import Foundation

class FavoritesManager {
    
    static let shared = FavoritesManager()
    private(set) var favorites: [Article] = []

    //id ile değil url ile benzersiz bir id varmış gibi yaptım. çünkü article sınıfının doğrudan bir id özelliği yok
    func addFavorite(article: Article) {
        if !favorites.contains(where: { $0.url == article.url }) { //zaten listede mi diye kontrol et
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
