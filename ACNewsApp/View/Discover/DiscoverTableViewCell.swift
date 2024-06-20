//
//  DiscoverTableViewCell.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 19.06.2024.
//


import UIKit
import SDWebImage

final class DiscoverTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "DiscoverTableViewCell"
    
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
    
    let descriptionLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 14, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .justified
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           contentView.backgroundColor = UIColor(named: "LigthBlack")
           contentView.addSubviews(newsImage, titleLabel, descriptionLabel)
           addConstraints()
           //setUpLayer()
    }
       
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    //CONSTRATINTS FUNC
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
           
            newsImage.heightAnchor.constraint(equalToConstant: 100),
            newsImage.widthAnchor.constraint(equalToConstant: 120),
            newsImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            // Hücrenin sağ kenarından 20 puan uzaklıkta
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -15),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 200),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        ])
    }
    
    override func prepareForReuse() { ///hücre yeniden kullanılmak üzere hazırlandıgında çağrırlır.
        super.prepareForReuse() /// metod super.prepareForReuse() çağrısı yapmakta, prepareforreuse hücre yeniden kullanılmak için çağırıldıgında yazılır. ARAŞTIR YENİDEN !!!
        
        newsImage.image = nil
        titleLabel.text = nil
    }
    
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

