//
//  ACNewsTableViewCell.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit
import SDWebImage

final class ACNewsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "ACNewsTableViewCell"
    
    //IMAGEVIEW
    let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //LABEL
     let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 5
         label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .close)
        let bookmarkImage = UIImage(systemName: "bookmark")
        button.setImage(bookmarkImage, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()

    var dateImage : UIImageView = {
        let calendar = UIImage(systemName: "calendar")
        let imageView = UIImageView(image: calendar)
        imageView.tintColor = UIColor(named: "LightRed")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var publishDateLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.text = "Publish Date"
       label.font = .systemFont(ofSize: 12, weight: .light)
       label.numberOfLines = 2
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
  /*  let descriptionLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 14, weight: .light)
       label.numberOfLines = 5
        label.textAlignment = .justified
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
   */
    // MARK: - Init
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubviews(newsImage, titleLabel, saveButton, dateImage, publishDateLabel)
        addConstraints()
        //setUpLayer()
       }
    
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    //CONSTRATINTS FUNC
    private func addConstraints() {
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowColor = UIColor.gray.cgColor
        
        NSLayoutConstraint.activate([
           
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            newsImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 100),
            newsImage.widthAnchor.constraint(equalToConstant: 180),
            
            // Hücrenin sağ kenarından 20 puan uzaklıkta
            
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 180),
            
            dateImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dateImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            publishDateLabel.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 5),
            publishDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.5),
            
            saveButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
   /* override func prepareForReuse() { ///hücre yeniden kullanılmak üzere hazırlandıgında çağrırlır.
        super.prepareForReuse() /// metod super.prepareForReuse() çağrısı yapmakta, prepareforreuse hücre yeniden kullanılmak için çağırıldıgında yazılır. ARAŞTIR YENİDEN !!!
        
        newsImage.image = nil
        titleLabel.text = nil
    }
    */
    
    override func layoutSubviews() {
            super.layoutSubviews()
            // contentView için iç boşluklar
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    //FUNC LOAD IMAGE
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            newsImage.image = nil // url geçersizse varsaylan resim
            return newsImage.image = UIImage(named: "noImage")
        }
        
        newsImage.sd_setImage(with: url, placeholderImage: UIImage(named: "loadingImage"))
    }
}