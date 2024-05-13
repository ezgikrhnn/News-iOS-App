//
//  ACSettingsOption.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 10.05.2024.
//

import UIKit

enum ACSettingsOption: CaseIterable{ //case iterable enum içerisindeki tüm caseleri erişilebilir kılar.
    
    case rateApp
    case contactUs
    case terms
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        
        //her seçeneğin urli
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://www.appcent.mobi/contact")
        case .terms:
            return URL(string: "https://www.appcent.mobi/services")
        
        case .apiReference:
            return URL(string: "https://newsapi.org/")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/@appcent_appcentakademi/featured")
        case .viewCode:
            return URL(string: "https://github.com/ezgikrhnn/ACNewsApp")
        }
    }
    
    //her case için kullanıcıya gösterilecek olan başlık.
    var displayTitle : String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Tersm of Service"
        
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    //her secenegin icon arkaplan rengi
    var iconContainercolor: UIColor{
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemYellow
        case .terms:
            return .systemPurple
        case .apiReference:
            return .systemBrown
        case .viewSeries:
            return .systemGreen
        case .viewCode:
            return .systemOrange
        }
    }
    //her seçeneğin icon resmi
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
       
}

