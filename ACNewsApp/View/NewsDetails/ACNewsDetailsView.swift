//
//  ACNewsDetailsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import UIKit

class ACNewsDetailsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //IMAGEVIEW
    let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] ///bu satır sayesinde imageView'in sadece üst 2 köşesine cornerRadius uygulandı.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()///closure
    
    let descriptionLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 14, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    let contentLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 14, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
}
