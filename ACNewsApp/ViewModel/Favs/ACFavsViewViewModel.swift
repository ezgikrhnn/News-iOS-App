//
//  ACFavsViewViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 11.05.2024.
//

import Foundation

class ACFavsViewViewModel {
    
    private var favorites: [Article] {
        return FavoritesManager.shared.favorites
    }
    
    var numberOfRows: Int { //fav listesinin eleman sayısı
        return favorites.count
    }
    
    func article(at index: Int) -> Article {
        return favorites[index]
    }
}
