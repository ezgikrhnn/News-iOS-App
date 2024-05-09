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

