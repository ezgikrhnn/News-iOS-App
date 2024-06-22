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

/*extension Notification.Name {
    static let didUpdateSavedArticles = Notification.Name("didUpdateSavedArticles")
}
 */

class SaveManager {
    
    
    static let shared = SaveManager()
    private(set) var saves: [Article] = []

    //id ile değil url ile benzersiz bir id varmış gibi yaptım. çünkü article sınıfının doğrudan bir id özelliği yok
    func addSave(article: Article) {
        if !saves.contains(where: { $0.url == article.url }) { //zaten listede mi diye kontrol et
            saves.append(article)
            //NotificationCenter.default.post(name: .didUpdateSavedArticles, object: nil)
        }
    }
    
    func removeSave(article: Article) {
        saves.removeAll(where: { $0.url == article.url })
       //NotificationCenter.default.post(name: .didUpdateSavedArticles, object: nil)
    }
    
    func isSave(article: Article) -> Bool { //url varsa true, yoksa false döner
        return saves.contains(where: { $0.url == article.url })
    }
    
    func getAllSaves() -> [Article] {
           return saves
    }
    
}
