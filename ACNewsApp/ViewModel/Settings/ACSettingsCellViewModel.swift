//
//  ACSettingsCellViewModel.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 10.05.2024.
//

import UIKit

struct ACSettingsCellViewModel: Identifiable {
    
    let id = UUID()
    public let type: ACSettingsOption
    public let onTapHandler: (ACSettingsOption) -> Void
    
    //MARK: -Init
    init(type: ACSettingsOption, onTapHandler: @escaping (ACSettingsOption) -> Void){
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    //MARK: -Public
    //Image | title
    public var image: UIImage? {
        return type.iconImage
    }
    public var title : String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor{
        return type.iconContainercolor
    }
}

