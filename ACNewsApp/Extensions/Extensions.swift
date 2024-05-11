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


