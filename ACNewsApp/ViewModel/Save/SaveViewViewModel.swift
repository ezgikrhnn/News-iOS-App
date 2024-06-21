//
//  ACFavsViewViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 11.05.2024.
//

import Foundation

class SaveViewViewModel {
    
    private var saves: [Article] {
        return SaveManager.shared.saves
    }
    
    var numberOfRows: Int { //fav listesinin eleman sayısı
        return saves.count
    }
    
    func article(at index: Int) -> Article {
        return saves[index]
    }
}
