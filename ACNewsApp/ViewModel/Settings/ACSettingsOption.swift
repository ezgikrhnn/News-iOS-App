//
//  ACSettingsOption.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 10.05.2024.
//

import UIKit

enum ACSettingsOption: CaseIterable{ //case iterable enum içerisindeki tüm caseleri erişilebilir kılar.
    
    case rateApp
    case contactMe
    case terms
    case apiReference
    case viewCode
    
    var targetUrl: URL? {
        
        //her seçeneğin urli
        switch self {
        case .rateApp:
            return nil
        case .contactMe:
            return URL(string: "https://www.linkedin.com/in/ezgikrhnn/")
        case .terms:
            return URL(string: "")
        case .apiReference:
            return URL(string: "https://newsapi.org/")
        case .viewCode:
            return URL(string: "https://github.com/ezgikrhnn/ACNewsApp")
        }
    }
    
    //her case için kullanıcıya gösterilecek olan başlık.
    var displayTitle : String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactMe:
            return "Contact Me"
        case .terms:
            return "Tersm of Service"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "View App Code"
        }
    }
    
    //her secenegin icon arkaplan rengi
    var iconContainercolor: UIColor{
        switch self {
        case .rateApp:
            return .systemRed
        case .contactMe:
            return .systemYellow
        case .terms:
            return .systemPurple
        case .apiReference:
            return .systemBrown
        case .viewCode:
            return .systemOrange
        }
    }
    //her seçeneğin icon resmi
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactMe:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
       
}

