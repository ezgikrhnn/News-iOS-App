//
//  Extensions.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit

extension UIView{
    
    /**... operatörü (variadic parametre), metodun birden fazla UIView nesnesi alabileceğini gösterir. **/
    func addSubviews(_ views: UIView...){
        views.forEach(){
            addSubview($0)
        }
    }
}

//sdwebimagesiz loadImage fonksiyonu
extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

extension UIViewController{
    
    
    func customizeNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "LightRed"),
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "LightRed"),
                .font: UIFont.systemFont(ofSize: 34, weight: .bold)
        ]
        
        // Arka plan rengi belirleniyor
        appearance.backgroundColor = .systemBackground
        
        // Tüm UINavigationBar örnekleri için bu appearance'ı ayarlıyoruz
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance // Opciyonel, daha küçük navigation barlar için
        UINavigationBar.appearance().scrollEdgeAppearance = appearance // Large Titles için
            
        // Navigation bar item'larının (başlık ve bar buttonlar) rengini ayarlar.
        UINavigationBar.appearance().tintColor = UIColor(named: "LightRed")
        // Navigation bar başlık rengini (title) ayarlar.
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "LightRed")]
        // Navigation bar büyük başlık rengini ayarlar (iOS 11 ve sonrası için).
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "LightRed")]
        // Navigation bar'ı şeffaf yapma ve gölgeyi kaldırma
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
     
}

